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
  end
end end
