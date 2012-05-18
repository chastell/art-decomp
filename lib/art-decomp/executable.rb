require 'trollop'

module ArtDecomp class Executable
  def initialize args
    opts = Trollop.options args do
      opt :archs, 'Target architecture(s)', type: :strings
      opt :dir,   'Results directory',      type: :string
    end

    Trollop.die 'no FSM given'             if     args.empty?
    Trollop.die 'FSM does not exist'       unless File.exists? args.first
    Trollop.die 'no architecture(s) given' unless opts[:archs_given]
    Trollop.die 'no directory given'       unless opts[:dir_given]
  end
end end
