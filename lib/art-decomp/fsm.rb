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

  def beta_f
    outs = @outputs.map { |output| Blanket.from_array output }
    outs.inject(:*) * Blanket.from_array(@next_state)
  end

  def beta_q
    Blanket.from_array @state
  end

  def beta_x ins
    return Blanket[B[*0...@state.size]] if ins.empty?
    ins.map { |i| Blanket.from_array @inputs[i] }.inject(:*)
  end

  def input_count
    @inputs.size
  end

  def state_rows_of_next_state_of rows
    state = @next_state[rows.bits.first]
    B[*(0...@state.size).select { |i| @state[i] == state }]
  end

  def to_kiss
    ins  = @inputs.transpose
    outs = @outputs.transpose
    st   = @state.map      { |e| e == DontCare ? '*' : e }
    nxt  = @next_state.map { |e| e == DontCare ? '*' : e }
    lines = [".i #{@inputs.size}", ".o #{@outputs.size}", ".p #{@state.size}", ".s #{(@state + @next_state - [DontCare]).uniq.size}"]
    lines += (0...@state.size).map { |i| [ins[i].join, st[i], nxt[i], outs[i].join].join ' ' }
    lines.join("\n") + "\n"
  end

  def x_encoding i, rows
    encoding @inputs[i], rows
  end

  def y_encoding rows
    @outputs.map { |output| encoding output, rows }.join.to_sym
  end

  private

  def encoding column, rows
    encs = rows.bits.map { |row| column[row] }.uniq - [DontCare]
    case encs.size
    when 0 then DontCare
    when 1 then encs.first
    else raise AmbiguousEncodingQuery, "ambiguous encoding query: block #{rows.bits.join ','}"
    end
  end

end end
