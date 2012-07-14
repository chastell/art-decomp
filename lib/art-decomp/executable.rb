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

    self.archs = opts[:archs].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set
    self.dir   = "#{opts[:dir]}/#{File.basename args.first}/#{archs.sort.reverse.map(&:to_s).join(' ').tr('/', ':')}"
    self.fsm   = FSM.from_kiss args.first
    self.uv    = opts[:uv].map { |name| UVGenerators.const_get(name).new }
    self.qu    = opts[:qu].map { |name| QuGenerators.const_get(name).new }
    self.qv    = opts[:qv].map { |name| QvGenerators.const_get(name).new }
  end

  def run opts
    FileUtils.mkdir_p dir
    decomposer = opts.fetch :decomposer
    decomposer.config = { archs: archs, fsm: fsm, gens: { uv: uv, qu: qu, qv: qv } }
    decomposer.dectrees.each.with_index do |dectree, i|
      File.write "#{dir}/#{i}.vhdl", dectree.to_vhdl
    end
  end

  private

  attr_accessor :archs, :dir, :fsm, :qu, :qv, :uv
end end
