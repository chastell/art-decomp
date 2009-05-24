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

    @uv_class = eval "UVGenerator::" + opts[:uv]
    @qu_class = eval "QuGenerator::" + opts[:qu]
    @qv_class = eval "QvGenerator::" + opts[:qv]
  end

  def run dump_tables = true
    decomposer = Decomposer.new :fsm => @fsm, :archs => @archs, :uv_class => @uv_class, :qu_class => @qu_class, :qv_class => @qv_class
    decs = []
    decomposer.decompositions.with_index do |dec, i|
      decs << dec
      File.write_data File.join(@dir, "#{i}.g"), dec.g_kiss if dump_tables
      File.write_data File.join(@dir, "#{i}.h"), dec.h_kiss if dump_tables
    end

    File.dump_object File.join(@dir, 'decompositions'), decs
  end

end end
