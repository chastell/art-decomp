module ArtDecomp class FSM

  def self.from_kiss kiss
    kiss = File.read kiss unless kiss.index "\n"
    inputs, outputs, state, next_state = [], [], [], []
    kiss.lines do |line|
      case line
      when /^\s*[01-]+\s+\S+\s+\S+\s+[01-]+\s*$/ then ins, st, nxt, outs = *line.split
      when /^\s*[01-]+\s+[01-]+\s*$/             then st, nxt, ins, outs = DontCare, DontCare, *line.split
      else next
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
    new inputs.transpose, outputs.transpose, state, next_state
  end

  def initialize inputs, outputs, state, next_state
    @inputs, @outputs, @state, @next_state = inputs.freeze, outputs.freeze, state.freeze, next_state.freeze
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
    FSM.from_kiss to_kiss.lines.map { |line| line.dc_expand(ins) }.flatten.sort.join
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
    "#{@inputs.size}/#{@outputs.size}+#{(@state.uniq - [DontCare]).size}s"
  end

  def to_kiss
    st   = @state.map      { |e| e == DontCare ? '*' : e }
    nxt  = @next_state.map { |e| e == DontCare ? '*' : e }
    div  = Array.new @state.size, ' '
    mid  = truth_table? ? [div] : [div, st, div, nxt, div]
    cols = @inputs + mid + @outputs
    KISS.new(cols.transpose.map(&:join)).formatted
  end

  # FIXME: move the template somewhere else?
  def to_vhdl name
    structure = Hash.new { |state, input| state[input] = {} }
    @state.each_index do |row|
      structure[@state[row]][@inputs.transpose[row].join] = {:next_state => @next_state[row], :output => @outputs.transpose[row].join}
    end
    when_lines = structure.map do |state, transitions|
      ["      when #{state} =>",
      transitions.map.with_index do |(input, results), i|
        "        #{'els' if i > 0}if input = \"#{input.tr '-', 'X'}\" then next_state <= #{results[:next_state]}; output <= \"#{results[:output]}\";"
      end,
      '        end if;']
    end
    <<-VHDL
library ieee;
use ieee.std_logic_1164.all;
entity #{name} is
  port(
    clock:  in  std_logic;
    reset:  in  std_logic;
    input:  in  std_logic_vector(#{@inputs.size - 1} downto 0);
    output: out std_logic_vector(#{@outputs.size - 1} downto 0)
  );
end #{name};
architecture behaviour of #{name} is
  type state is (#{@state.uniq.join ', '});
  signal current_state, next_state: state;
begin
  process(clock, reset) begin
    if clock'event and clock = '1' then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    case current_state is
#{when_lines.join "\n"}
    end case;
  end process;
end behaviour;
    VHDL
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
    i_seps = Hash[i_seps.map { |i, seps| [i, seps - i_seps.reject { |o,| o == i }.values.inject(Set[], :+)] }] if unique
    more, less = i_seps.map { |i, seps| [seps.size, i] }.sort.reverse.reject { |rel,| rel.zero? }.partition { |rel,| rel > perpin }
    more.map(&:last) + [nil] * beta_q.pins + less.map(&:last)
  end

end end
