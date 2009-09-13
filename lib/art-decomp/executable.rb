require 'trollop'

module ArtDecomp class Executable

  attr_reader :archs, :depth, :dir

  def initialize args = ARGV
    opts = Trollop.options(args) do
      opt :archs,  'Target architecture(s)', :type => :strings
      opt :depth,  'Depth of the process',   :default => 1
      opt :log,    'Logging target',         :type => :string
      opt :outdir, 'Output directory',       :type => :string
      opt :uv,     'UV generator(s)',        :default => ['Braindead']
      opt :qu,     'Qu generator(s)',        :default => ['BlockTable']
      opt :qv,     'Qv generator(s)',        :default => ['GraphColouring']
    end

    opts[:uv] = UVGenerator.constants if opts[:uv] == ['all']
    opts[:qu] = QuGenerator.constants if opts[:qu] == ['all']
    opts[:qv] = QvGenerator.constants if opts[:qv] == ['all']

    Trollop.die          'no FSM given'                      if     args.empty?
    Trollop.die          'FSM does not exist'                unless File.exists? args.first
    Trollop.die          'no architecture given'             unless opts[:archs_given]
    Trollop.die          'no output directory given'         unless opts[:outdir_given]
    Trollop.die :archs,  'not in the form of inputs/outputs' unless opts[:archs].all? { |s| s =~ /^\d+\/\d+$/ }
    Trollop.die :outdir, 'output directory exists'           if     File.exists? opts[:outdir]
    Trollop.die :uv,     'no such UV generator'              unless (opts[:uv].map(&:to_sym) - UVGenerator.constants).empty?
    Trollop.die :qu,     'no such Qu generator'              unless (opts[:qu].map(&:to_sym) - QuGenerator.constants).empty?
    Trollop.die :qv,     'no such Qv generator'              unless (opts[:qv].map(&:to_sym) - QvGenerator.constants).empty?

    Dir.mkdir opts[:outdir] rescue Trollop.die :outdir, 'output directory cannot be created'

    @dir   = opts[:outdir]
    @fsm   = FSM.from_kiss args.first
    @archs = opts[:archs].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set
    @depth = opts[:depth]

    @uv_gens = opts[:uv].map { |gen| eval "UVGenerator::#{gen}" }
    @qu_gens = opts[:qu].map { |gen| eval "QuGenerator::#{gen}" }
    @qv_gens = opts[:qv].map { |gen| eval "QvGenerator::#{gen}" }

    if opts[:log_given]
      require_relative 'logging'
      Logging.log = opts[:log] == '-' ? $stdout : opts[:log]
    end
  end

  def run dump_decs = true
    dumps = Hash.new { |h, k| h[k] = [] }
    decompositions(@fsm, @depth, @dir).each do |dec, dir, i|
      dumps[dir] << dec
      File.dump_object dec, "#{dir}/#{i}.dec" if dump_decs
    end
    dumps.each do |dir, decs|
      File.dump_object decs, "#{dir}/decompositions"
    end
  end

  private

  def decompositions fsm, depth, dir
    decomposer = Decomposer.new :fsm => fsm, :archs => @archs, :uv_gens => @uv_gens, :qu_gens => @qu_gens, :qv_gens => @qv_gens
    Enumerator.new do |yielder|
      decomposer.decompositions.with_index do |dec, i|
        yielder.yield dec, dir, i
        if depth > 1 and dec.decomposable? and not dec.final? @archs
          in_dir = "#{dir}/#{i}"
          Dir.mkdir in_dir
          decompositions(FSM.from_kiss(dec.h_kiss), depth - 1, in_dir).each do |in_dec, in_dir, in_i|
            yielder.yield in_dec, in_dir, in_i
          end
        end
      end
    end
  end

end end
