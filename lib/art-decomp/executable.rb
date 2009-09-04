require 'trollop'

module ArtDecomp class Executable

  def initialize args = ARGV
    opts = Trollop.options(args) do
      opt :archs,  'Target architecture(s)', :type => :strings
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
    Trollop.die :archs,  'not in the form of inputs/outputs' unless opts[:archs].all? { |s| s =~ /^\d+\/\d+$/ }
    Trollop.die :outdir, 'no output directory given'         unless opts[:outdir_given]
    Trollop.die :outdir, 'output directory exists'           if     File.exists? opts[:outdir]
    Trollop.die :uv,     'no such UV generator'              unless (opts[:uv].map(&:to_sym) - UVGenerator.constants).empty?
    Trollop.die :qu,     'no such Qu generator'              unless (opts[:qu].map(&:to_sym) - QuGenerator.constants).empty?
    Trollop.die :qv,     'no such Qv generator'              unless (opts[:qv].map(&:to_sym) - QvGenerator.constants).empty?

    Dir.mkdir opts[:outdir] rescue SystemCallError Trollop.die :outdir, 'output directory cannot be created'

    @dir   = opts[:outdir]
    @fsm   = FSM.from_kiss args.first
    @archs = opts[:archs].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set

    @uv_gens = opts[:uv].map { |gen| eval "UVGenerator::#{gen}" }
    @qu_gens = opts[:qu].map { |gen| eval "QuGenerator::#{gen}" }
    @qv_gens = opts[:qv].map { |gen| eval "QvGenerator::#{gen}" }
  end

  def run dump_tables = true
    decomposer = Decomposer.new :fsm => @fsm, :archs => @archs, :uv_gens => @uv_gens, :qu_gens => @qu_gens, :qv_gens => @qv_gens
    decs = []
    decomposer.decompositions.with_index do |dec, i|
      decs << dec
      File.write_data dec.g_kiss, File.join(@dir, "#{i}.g") if dump_tables
      File.write_data dec.h_kiss, File.join(@dir, "#{i}.h") if dump_tables
    end

    File.dump_object decs, File.join(@dir, 'decompositions')
  end

end end
