require 'trollop'

module ArtDecomp class Executable

  def initialize args = ARGV
    opts = Trollop::options(args) do
      opt :arch,   'Target architecture', :type => :string, :multi => true
      opt :outdir, 'Output directory',    :type => :string
      opt :uv,     'UV generator',        :default => 'Braindead'
      opt :qu,     'Qu generator',        :default => 'BlockTable'
      opt :qv,     'Qv generator',        :default => 'GraphColouring'
    end

    Trollop::die          'no FSM given'                      unless args.first
    Trollop::die          'FSM does not exist'                unless File.exists? args.first
    Trollop::die          'no architecture given'             unless opts[:arch_given]
    Trollop::die :arch,   'not in the form of inputs/outputs' unless opts[:arch].all? { |s| s =~ /^\d+\/\d+$/ }
    Trollop::die :outdir, 'no output directory given'         unless opts[:outdir_given]
    Trollop::die :outdir, 'output directory exists'           if     File.exists? opts[:outdir]
    Trollop::die :uv,     'no such UV generator'              unless UVGenerator.constants.include? opts[:uv].to_sym
    Trollop::die :qu,     'no such Qu generator'              unless QuGenerator.constants.include? opts[:qu].to_sym
    Trollop::die :qv,     'no such Qv generator'              unless QvGenerator.constants.include? opts[:qv].to_sym

    Dir.mkdir opts[:outdir] rescue SystemCallError Trollop::die :outdir, 'output directory cannot be created'

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
    decomposer.each.with_index do |dec, i|
      decs << dec
      if dump_tables
        Dir.mkdir File.join(@dir, i.to_s)
        File.open(File.join(@dir, i.to_s, 'g'), 'w') { |f| f << dec.g_table }
        File.open(File.join(@dir, i.to_s, 'h'), 'w') { |f| f << dec.h_table }
      end
    end

    filename = File.join @dir, 'decompositions'
    File.open(filename, 'w') { |f| f << Marshal.dump(decs) }
  end

end end
