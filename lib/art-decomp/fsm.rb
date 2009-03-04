module ArtDecomp class FSM

  def self.from_kiss file
    inputs, outputs, state, next_state = [], [], [], []
    IO.read(file).each_line do |line|
      next unless line =~ /^\s*[01-]+\s+\S+\s+\S+\s+[01-]+\s*$/
      ins, st, nxt, outs = line.split
      inputs     << ins.split(//).map(&:to_sym)
      outputs    << outs.split(//).map(&:to_sym)
      state      << (st  == '*' ? DontCare : st.to_sym)
      next_state << (nxt == '*' ? DontCare : nxt.to_sym)
    end
    new inputs.transpose, outputs.transpose, state, next_state
  end

  def initialize inputs, outputs, state, next_state
    @inputs, @outputs, @state, @next_state = inputs, outputs, state, next_state
  end

  def input_count
    @inputs.size
  end

end end
