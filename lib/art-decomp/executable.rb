require 'trollop'

module ArtDecomp class Executable

  attr_reader :archs, :best, :iters, :dir

  def initialize args = ARGV
    opts = Trollop.options(args) do
      opt :archs,        'Target architecture(s)',               :type => :strings
      opt :outdir,       'Output directory',                     :type => :string
      opt :iters,        'Number of iterations, 0 for infinite', :default => 1
      opt :uv,           'UV generator(s)',                      :default => ['Relevance']
      opt :qu,           'Qu generator(s)',                      :default => ['EdgeLabels']
      opt :qv,           'Qv generator(s)',                      :default => ['GraphColouring']
      opt :non_disjoint, 'Compute non-disjoint decompositions',  :default => false
      opt :deep_ndj,     'Compute deep non-dj decompositions',   :default => false
      opt :log,          'Logging target',                       :type => :string
      opt :debug,        'Log debug-level activities',           :default => false
    end

    opts[:uv] = UVGenerator.constants.map(&:to_s).sort if opts[:uv] == ['all']
    opts[:qu] = QuGenerator.constants.map(&:to_s).sort if opts[:qu] == ['all']
    opts[:qv] = QvGenerator.constants.map(&:to_s).sort if opts[:qv] == ['all']

    Trollop.die          'no FSM given'                      if     args.empty?
    Trollop.die          'FSM does not exist'                unless File.exists? args.first
    Trollop.die          'no architecture given'             unless opts[:archs_given]
    Trollop.die          'no output directory given'         unless opts[:outdir_given]
    Trollop.die :archs,  'not in the form of inputs/outputs' unless opts[:archs].all? { |s| s =~ /^\d+\/\d+$/ }
    Trollop.die :outdir, 'output directory exists'           if     File.exists? opts[:outdir]
    Trollop.die :uv,     'no such UV generator'              unless (opts[:uv] - UVGenerator.constants.map(&:to_s)).empty?
    Trollop.die :qu,     'no such Qu generator'              unless (opts[:qu] - QuGenerator.constants.map(&:to_s)).empty?
    Trollop.die :qv,     'no such Qv generator'              unless (opts[:qv] - QvGenerator.constants.map(&:to_s)).empty?

    Dir.mkdir opts[:outdir] rescue Trollop.die :outdir, 'output directory cannot be created'

    @dir          = opts[:outdir]
    @fsm          = FSM.from_kiss args.first
    @archs        = opts[:archs].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set
    @iters        = opts[:iters]
    @non_disjoint = opts[:non_disjoint]
    @deep_ndj     = opts[:deep_ndj]

    @uv_gens = opts[:uv].map { |gen| eval "UVGenerator::#{gen}" }
    @qu_gens = opts[:qu].map { |gen| eval "QuGenerator::#{gen}" }
    @qv_gens = opts[:qv].map { |gen| eval "QvGenerator::#{gen}" }

    if opts[:log_given]
      require_relative 'logging'
      Logging.log = opts[:log] == '-' ? $stdout : opts[:log]
      Logging.level = Logger::DEBUG if opts[:debug]
    end
  end

  def gens
    [@uv_gens, @qu_gens, @qv_gens].map do |gens|
      gens.map { |gen| gen.to_s.split('::').last }.join '+'
    end.join ', '
  end

  def run dump_decs = true
    @best = @fsm.fsm_cells @archs
    dumps = Hash.new { |h, k| h[k] = [] }
    decompositions(@fsm, @iters, @dir, 0).each do |dec, dir, i|
      dumps[dir] << dec
      File.dump_object dec, "#{dir}/#{i}.dec" if dump_decs
    end unless @fsm.implementable_in? @archs
    dumps.each do |dir, decs|
      File.dump_object decs, "#{dir}/decompositions"
    end
  end

  private

  def decompositions fsm, iters, dir, cells
    decomposer = Decomposer.new :fsm => fsm, :archs => @archs, :uv_gens => @uv_gens, :qu_gens => @qu_gens, :qv_gens => @qv_gens
    Enumerator.new do |yielder|
      decomposer.decompositions(:non_disjoint => @non_disjoint, :deep_ndj => @deep_ndj).with_index do |dec, i|
        yielder.yield dec, dir, i
        if dec.final? @archs
          this = cells + dec.g_cells(@archs) + dec.h_cells(@archs)
          @best = this if @best.nil? or this < @best
        elsif iters != 1 and dec.symbolic? and (@best.nil? or cells < @best)
          in_dir = "#{dir}/#{i}"
          Dir.mkdir in_dir
          decompositions(FSM.from_kiss(dec.h_kiss), iters - 1, in_dir, cells + dec.g_cells(@archs)).each do |in_dec, in_dir, in_i|
            yielder.yield in_dec, in_dir, in_i
          end
        end
      end
    end
  end

end end
