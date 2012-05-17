require 'trollop'

module ArtDecomp class Executable
  def initialize args
    opts = Trollop.options args

    Trollop.die 'no FSM given'             if     args.empty?
    Trollop.die 'FSM does not exist'       unless File.exists? args.first
    Trollop.die 'no architecture(s) given' unless opts[:archs_given]
  end
end end
