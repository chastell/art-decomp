require 'trollop'

module ArtDecomp class Executable

  def initialize args = ARGV
    opts = Trollop.options(args) do
      opt :arch,   'Target architecture', :type => :string, :multi => true
      opt :outdir, 'Output directory',    :type => :string
      opt :uv,     'UV generator',        :default => 'Braindead'
      opt :qu,     'Qu generator',        :default => 'BlockTable'
      opt :qv,     'Qv generator',        :default => 'GraphColouring'
    end

    Trollop.die          'no FSM given'                      if     args.empty?
    Trollop.die          'FSM does not exist'                unless File.exists? args.first
    Trollop.die          'no architecture given'             unless opts[:arch_given]
    Trollop.die :arch,   'not in the form of inputs/outputs' unless opts[:arch].all? { |s| s =~ /^\d+\/\d+$/ }
    Trollop.die :outdir, 'no output directory given'         unless opts[:outdir_given]
    Trollop.die :outdir, 'output directory exists'           if     File.exists? opts[:outdir]
    Trollop.die :uv,     'no such UV generator'              unless UVGenerator.constants.include? opts[:uv].to_sym
    Trollop.die :qu,     'no such Qu generator'              unless QuGenerator.constants.include? opts[:qu].to_sym
    Trollop.die :qv,     'no such Qv generator'              unless QvGenerator.constants.include? opts[:qv].to_sym

    Dir.mkdir opts[:outdir] rescue SystemCallError Trollop.die :outdir, 'output directory cannot be created'

    @dir   = opts[:outdir]
    @fsm   = FSM.from_kiss args.first
    @archs = opts[:arch].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set

    @uv_gen = eval "UVGenerator::" + opts[:uv]
    @qu_gen = eval "QuGenerator::" + opts[:qu]
    @qv_gen = eval "QvGenerator::" + opts[:qv]
  end

  def run dump_tables = true
    decomposer = Decomposer.new :fsm => @fsm, :archs => @archs, :uv_gens => [@uv_gen], :qu_gens => [@qu_gen], :qv_gens => [@qv_gen]
    decs = []
    decomposer.decompositions.with_index do |dec, i|
      decs << dec
      File.write_data dec.g_kiss, File.join(@dir, "#{i}.g") if dump_tables
      File.write_data dec.h_kiss, File.join(@dir, "#{i}.h") if dump_tables
    end

    File.dump_object decs, File.join(@dir, 'decompositions')
  end

end end
