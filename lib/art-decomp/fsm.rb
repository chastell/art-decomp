module ArtDecomp class FSM

  def self.from_kiss kiss
    kiss = File.read kiss unless kiss.index "\n"
    inputs, outputs, state, next_state = [], [], [], []
    kiss.lines do |line|
      next unless line =~ /^\s*[01-]+\s+\S+\s+\S+\s+[01-]+\s*$/
      ins, st, nxt, outs = line.split
      inputs     << ins.split(//).map(&:to_sym)
      outputs    << outs.split(//).map(&:to_sym)
      state      << (st  == '*' ? DontCare : st.to_sym)
      next_state << (nxt == '*' ? DontCare : nxt.to_sym)
    end
    # FIXME: the below hack makes state have all possible values
    (next_state - state - [DontCare]).each do |missing_state|
      i = state.index DontCare
      state      << missing_state
      next_state << next_state[i]
      inputs     << inputs[i]
      outputs    << outputs[i]
    end
    new inputs.transpose, outputs.transpose, state, next_state
  end

  def initialize inputs, outputs, state, next_state
    @inputs, @outputs, @state, @next_state = inputs.freeze, outputs.freeze, state.freeze, next_state.freeze
  end

  def == other
    [@inputs, @outputs, @state, @next_state] == [other.inputs, other.outputs, other.state, other.next_state]
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

  alias eql? ==

  def expand_x ins
    return self unless ins.any? { |i| @inputs[i].include? DontCare }
    FSM.from_kiss to_kiss.lines.map { |line| line.dc_expand(ins) }.flatten.sort.join
  end

  def fsm_cells archs
    return 0 if @outputs.map { |output| Blanket.from_array output }.inject(:*).size < 2
    pons = archs.select { |a| a.pins >= input_count + beta_q.pins }.map(&:pons).max
    outputs = output_count + beta_q.pins
    (outputs % pons).zero? ? outputs / pons : outputs / pons + 1 rescue nil
  end

  def hash
    @inputs.hash ^ @outputs.hash ^ @state.hash ^ @next_state.hash
  end

  def implementable_in? archs
    return true if @outputs.map { |output| Blanket.from_array output }.inject(:*).size < 2
    input_count + beta_q.pins <= archs.map(&:pins).max
  end

  def input_count
    @inputs.size
  end

  def q_encoding rows
    # FIXME: consider tr DontCare, '*'
    encoding @state, rows
  end

  def output_count
    @outputs.size
  end

  def state_rows_of_next_state_of rows
    state = @next_state[rows.bits.first]
    B[*(0...@state.size).select { |i| @state[i] == state or @state[i] == DontCare }]
  end

  def stats
    "#{@inputs.size}/#{@outputs.size}/#{(@state.uniq - [DontCare]).size}s"
  end

  def to_kiss
    st   = @state.map      { |e| e == DontCare ? '*' : e }
    nxt  = @next_state.map { |e| e == DontCare ? '*' : e }
    div  = Array.new @state.size, ' '
    cols = @inputs + [div, st, div, nxt, div] + @outputs
    KISS.new(cols.transpose.map(&:join)).formatted
  end

  def x_encoding ins, rows
    ins.map { |i| encoding @inputs[i], rows }.join
  end

  def y_encoding rows
    @outputs.map { |output| encoding output, rows }.join
  end

  protected

  attr_reader :inputs, :outputs, :state, :next_state

  private

  def encoding column, rows
    encs = rows.bits.map { |row| column[row] }.uniq - [DontCare]
    case encs.size
    when 0 then DontCare.to_s
    when 1 then encs.first.to_s
    else raise AmbiguousEncodingQuery, "ambiguous encoding query: block #{rows.bits.join ','}"
    end
  end

end end
