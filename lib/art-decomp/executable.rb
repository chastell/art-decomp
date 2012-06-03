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

    @archs = opts[:archs].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set
    @dir   = FileUtils.mkdir_p "#{opts[:dir]}/#{File.basename args.first}/#{@archs.sort.reverse.map(&:to_s).join(' ').tr '/', ':'}/#{Time.now}"
    @fsm   = FSM.from_kiss args.first

    @uv_gens = opts[:uv].map { |gen| UVGenerators.const_get gen }
    @qu_gens = opts[:qu].map { |gen| QuGenerators.const_get gen }
    @qv_gens = opts[:qv].map { |gen| QvGenerators.const_get gen }

    if opts[:log_given]
      require 'logger'
      log = opts[:log] == '-' ? $stdout : opts[:log]
      ArtDecomp.const_set 'Log', Logger.new(log)
      Log.level = opts[:debug] ? Logger::DEBUG : Logger::INFO
    end
  end

  def run
    @best = @fsm.fsm_cells @archs
    if @best
      Log.warn "FSM #{@fsm.stats} is directly implementable in #{@archs.sort.reverse.map(&:to_s).join '+'} with #{@best} cells"
    else
      decs.each do |dec|
        puts
        puts
        puts
        puts "==============================="
        puts dec.to_kiss
        puts "==============================="
        puts
        puts
        puts
      end
    end
  end

  private

  def decs fsm = @fsm
    Enumerator.new do |yielder|
      decomposer = Decomposer.new fsm: fsm, archs: @archs, uv_gens: @uv_gens, qu_gens: @qu_gens, qv_gens: @qv_gens
      decomposer.decompositions.each do |dec|
        if dec.final? @archs
          yielder.yield dec, true
        else
          yielder.yield dec, false
          decs(FSM.from_kiss(dec.h_kiss)).each do |in_dec, final|
            yielder.yield in_dec, final
          end
        end
      end
    end
  end

  def decompositions opts = {}
    fsm   = opts.fetch :fsm,   @fsm
    cells = opts.fetch :cells, 0
    level = opts.fetch :level, 0

    decomposer = Decomposer.new fsm: fsm, archs: @archs, uv_gens: @uv_gens, qu_gens: @qu_gens, qv_gens: @qv_gens
    Enumerator.new do |yielder|
      decomposer.decompositions(level: level).each do |dec|
        yielder.yield dec
        if dec.final? @archs
          this = cells + dec.g_cells(@archs) + dec.h_cells(@archs)
          @best = this if @best.nil? or this < @best
        elsif dec.symbolic? and (@best.nil? or cells < @best)
          decompositions(fsm: FSM.from_kiss(dec.h_kiss), cells: cells + dec.g_cells(@archs), level: level + 1).each do |in_dec|
            yielder.yield in_dec
          end
        end
      end
    end
  end
end end
