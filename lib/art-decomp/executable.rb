module ArtDecomp class Executable
  def initialize args
    abort 'no FSM given'       if     args.empty?
    abort 'FSM does not exist' unless File.exists? args.first
  end
end end
