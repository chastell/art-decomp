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
  end
end end
