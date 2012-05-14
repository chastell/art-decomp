require 'trollop'

module ArtDecomp class Executable
  def initialize args
    Trollop.options args
    Trollop.die 'no FSM given'       if     args.empty?
    Trollop.die 'FSM does not exist' unless File.exists? args.first
  end
end end
