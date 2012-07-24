require 'fileutils'
require 'trollop'

module ArtDecomp class Executable
  def initialize args
    opts = Trollop.options args do
      opt :archs, 'Target architecture(s)', required: true, type: :strings
      opt :dir,   'Results directory',      required: true, type: :string
      opt :log,   'Logging level',          type: :string
      opt :uv,    'UV generator(s)',        default: ['RelativeRelevance']
      opt :qu,    'Qu generator(s)',        default: ['EdgeLabels']
      opt :qv,    'Qv generator(s)',        default: ['GraphColouring']
    end

    Trollop.die 'no FSM given'       if     args.empty?
    Trollop.die 'FSM does not exist' unless File.exists? args.first

    Trollop.die :archs, 'not in the form of inputs/outputs' unless opts[:archs].all? { |s| s =~ /^\d+\/\d+$/ }
    Trollop.die :uv,    'generator does not exist'          unless (opts[:uv] - UVGenerators.constants.map(&:to_s)).empty?
    Trollop.die :qu,    'generator does not exist'          unless (opts[:qu] - QuGenerators.constants.map(&:to_s)).empty?
    Trollop.die :qv,    'generator does not exist'          unless (opts[:qv] - QvGenerators.constants.map(&:to_s)).empty?

    fsm_path = args.first
    @fsm_name = File.basename fsm_path

    @archs = opts[:archs].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set
    @dir   = "#{opts[:dir]}/#{@fsm_name}/#{@archs.sort.reverse.map(&:to_s).join(' ').tr '/', ':'}/#{Time.now}"
    @fsm   = FSM.from_kiss fsm_path

    FileUtils.mkdir_p @dir

    @uv_gens = opts[:uv].map { |gen| UVGenerators.const_get gen }
    @qu_gens = opts[:qu].map { |gen| QuGenerators.const_get gen }
    @qv_gens = opts[:qv].map { |gen| QvGenerators.const_get gen }

    if opts[:log_given]
      require 'logger'
      ArtDecomp.const_set 'Log', Logger.new($stdout)
      Log.level = Logger.const_get opts[:log].upcase
    end
  end

  def run
    @best = @fsm.fsm_cells @archs
    if @best
      Log.fatal "FSM #{@fsm.stats} is directly implementable in #{@archs.sort.reverse.map(&:to_s).join '+'} with #{@best} cells"
    else
      dectrees.each.with_index do |tree, i|
        tree.each.with_index do |dec, j|
          File.open("#{@dir}/#{@fsm_name}.#{i}.#{j}.kiss", 'w') { |f| f << dec.to_kiss }
        end
        name    = "#{@fsm_name}_#{i}"
        dectree = DecTree.new tree, @archs
        Log.error "#{name}: #{dectree.cells} cells, depth #{tree.size}" if defined? Log
        File.open("#{@dir}/#{name}.vhdl", 'w') do |f|
          f << dectree.to_vhdl(name)
        end
      end
    end
  end

  private

  def dectrees fsm = @fsm, dectree = []
    Enumerator.new do |yielder|
      decomposer = Decomposer.new fsm: fsm, archs: @archs, uv_gens: @uv_gens, qu_gens: @qu_gens, qv_gens: @qv_gens
      decomposer.decompositions(level: dectree.size).each do |dec|
        dectree << dec
        cells = DecTree.new(dectree, @archs).cells
        @best = cells if cells and (@best.nil? or cells < @best)
        break if @best and cells and @best < cells
        if dec.final? @archs
          yielder.yield dectree
        elsif dec.symbolic?
          dectrees(FSM.from_kiss(dec.h_kiss), dectree).each do |subtree|
            yielder.yield subtree
          end
        end
        dectree.pop
      end
    end
  end
end end
