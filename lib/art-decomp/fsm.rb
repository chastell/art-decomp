module ArtDecomp class FSM
  attr_reader :codes

  def self.from_kiss kiss
    kiss = File.read kiss unless kiss.index "\n"
    inputs, outputs, state, next_state = [], [], [], []
    codes = Hash[kiss.lines.grep(/^\.code [^*]/).map(&:split).map { |_, state, code| [state.to_sym, code.to_sym] }]
    codes = Hash[kiss.lines.grep(/^# States\./).map(&:split).map { |_, state, code| [state[7..-1].to_sym, code.to_sym] }] if codes.empty?
    kiss.lines do |line|
      case line
      when /^\s*[\d-]+\s+\S+\s+\S+\s+[\d-]+\s*$/ then ins, st, nxt, outs = *line.split
      when /^\s*[\d-]+\s+[\d-]+\s*$/             then st, nxt, ins, outs = DontCare, DontCare, *line.split
      when /^\.end_kiss$/                        then break
      else next
      end
      next if [DontCare, '*'].include? nxt and outs =~ /^-*$/
      if line =~ /^[01-]+\s+[01-]+$/ and not codes.empty?
        size = codes.values.first.size
        st   = ins[-size..-1] == '-' * size ? DontCare : codes.invert[ins[-size..-1].to_sym]
        nxt  = outs[0...size] == '-' * size ? DontCare : codes.invert[outs[0...size].to_sym]
        ins  = ins[0...-size]
        outs = outs[size..-1]
      end
      inputs     << ins.split(//).map(&:to_sym)
      outputs    << outs.split(//).map(&:to_sym)
      state      << (st  == '*' ? DontCare : st.to_sym)
      next_state << (nxt == '*' ? DontCare : nxt.to_sym)
    end
    # FIXME: the below hack makes state have all possible values by expanding a don’t-care a bit (if present)
    (next_state - state - [DontCare]).each do |missing_state|
      i = state.index DontCare
      state      << missing_state
      next_state << next_state[i]
      inputs     << inputs[i]
      outputs    << outputs[i]
    end if state.index DontCare
    new inputs.transpose, outputs.transpose, state, next_state, codes
  end

  def initialize inputs, outputs, state, next_state, codes = {}
    @inputs, @outputs, @state, @next_state, @codes = inputs.freeze, outputs.freeze, state.freeze, next_state.freeze, codes.freeze
  end

  def == other
    [@inputs, @outputs, @state, @next_state] == [other.inputs, other.outputs, other.state, other.next_state]
  end

  def beta_f
    @outputs.map { |o| Blanket.from_array o }.inject(:*) * Blanket.from_array(@next_state)
  end

  def beta_q
    Blanket.from_array @state
  end

  def beta_qp
    Blanket.from_array @next_state
  end

  def beta_x ins
    beta @inputs, ins
  end

  def beta_y ins
    beta @outputs, ins
  end

  alias eql? ==

  def expand_x ins
    return self unless ins.any? { |i| @inputs[i].include? DontCare }
    FSM.from_kiss to_kiss.lines.map { |line| line.extend(CoreExtensions::String).dc_expand(ins) }.flatten.sort.join
  end

  def fsm_cells archs
    return 0 if @outputs.map { |output| Blanket.from_array output }.inject(:*).size < 2
    Arch[input_count + beta_q.pins, output_count + beta_q.pins].cells archs
  end

  def general_relevance
    relevance false
  end

  def hash
    @inputs.hash ^ @outputs.hash ^ @state.hash ^ @next_state.hash
  end

  def implementable_in? archs
    not fsm_cells(archs).nil?
  end

  def input_count
    @inputs.size
  end

  def output_count
    @outputs.size
  end

  def q_encoding rows
    # FIXME: consider tr DontCare, '*'
    encoding @state, rows
  end

  def state_rows_of_next_state_of rows
    state = @next_state[rows.bits.first]
    B[*(0...@state.size).select { |i| @state[i] == state or @state[i] == DontCare }]
  end

  def stats
    "#{@inputs.size}/#{@outputs.size}+#{(@state.uniq - [DontCare]).size}s"
  end

  def structure
    structure = Hash.new { |state, input| state[input] = {} }
    @state.each_index do |row|
      structure[@state[row]][@inputs.transpose[row].join] = {next_state: @next_state[row], output: @outputs.transpose[row].join}
    end
    structure
  end

  def to_kiss
    st   = @state.map      { |e| e == DontCare ? '*' : e }
    nxt  = @next_state.map { |e| e == DontCare ? '*' : e }
    div  = Array.new @state.size, ' '
    mid  = truth_table? ? [div] : [div, st, div, nxt, div]
    cols = @inputs + mid + @outputs
    KISS.new(cols.transpose.map(&:join)).formatted
  end

  def to_vhdl name
    VHDL.new(self).vhdl name
  end

  def truth_table?
    @state.all? { |s| s == DontCare } and @next_state.all? { |ns| ns == DontCare }
  end

  def unique_relevance
    relevance true
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

  def beta column, ins
    return Blanket[B[*0...@state.size]] if ins.empty?
    ins.map { |i| Blanket.from_array column[i] }.inject :*
  end

  def encoding column, rows
    encs = rows.bits.map { |row| column[row] }.uniq - [DontCare]
    case encs.size
    when 0 then DontCare.to_s
    when 1 then encs.first.to_s
    else raise AmbiguousEncodingQuery, "ambiguous encoding query: block #{rows.bits.join ','}"
    end
  end

  def relevance unique
    f_seps = beta_f.seps
    i_seps = Hash[(0...input_count).map { |i| [i, beta_x(Set[i]).seps & f_seps] }]
    q_seps = beta_q.seps & f_seps
    q_seps -= i_seps.values.inject :+ if unique
    perpin = q_seps.size.to_f / beta_q.pins
    i_seps = Hash[i_seps.map { |i, seps| [i, seps - q_seps - i_seps.reject { |o,| o == i }.values.inject(Set[], :+)] }] if unique
    more, less = i_seps.map { |i, seps| [seps.size, i] }.sort.reverse.reject { |rel,| rel.zero? }.partition { |rel,| rel > perpin }
    more.map(&:last) + [nil] * beta_q.pins + less.map(&:last)
  end
end end
