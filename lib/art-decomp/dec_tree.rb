module ArtDecomp class DecTree
  attr_accessor :archs, :decs, :fsm

  def initialize decs, archs
    self.archs = archs
    self.decs  = decs
    self.fsm   = decs.first.fsm
  end

  def cells
    decs.map { |d| d.g_cells(archs) }.inject(:+) + decs.last.h_cells(archs)
  end

  def to_vhdl name = 'full_4'
    <<-end
-- #{cells} cells of target arch (#{archs.map(&:to_s).join ' + ' })
-- G archs: #{decs.map { |d| d.g_arch.to_s }.join ' ' }
-- H arch: #{decs.last.h_arch.to_s }

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity #{name} is
  port(
        reset: in  std_logic;
        clock: in  std_logic;
        fsm_i: in  std_logic_vector(0 to #{fsm.input_count - 1});
        fsm_o: out std_logic_vector(0 to #{fsm.output_count - 1})
      );
end #{name};

architecture behaviour of #{name} is

  signal fsm_q, fsm_qp: std_logic_vector(0 to #{state_pins - 1});

  #{signals_d}

  signal d#{decs.size - 1}_h_i: std_logic_vector(0 to #{decs.last.u.size + decs.last.qu.pins + decs.last.g.pins - 1});
  signal d#{decs.size - 1}_h_o: std_logic_vector(0 to #{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - 1});

begin

  #{structures_d}

  d#{decs.size - 1}_h_i <= (#{decs.last.u.sort.map { |i| "d#{decs.size - 1}_x(#{i})" }.join ' & '} & d#{decs.size - 1}_g_o & d#{decs.size - 1}_qu);

  fsm_qp <= d#{decs.size - 1}_h_o(0 to #{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - fsm.output_count - 1});
  fsm_o  <= d#{decs.size - 1}_h_o(#{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - fsm.output_count} to #{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - 1});

  process(reset, clock) begin
    if reset = '1' then fsm_q <= "#{first_state}";
    elsif rising_edge(clock) then fsm_q <= fsm_qp;
    end if;
  end process;

  #{g_blocks}

#{h_block}
end behaviour;
    end
  end

  private

  def g_block d
    lines = decs[d].g_kiss.lines.to_a
    fline = lines.shift.split
    el_if = lines.map do |line|
      "    elsif std_match(d#{d}_g_i, \"#{line.split.first}\") then d#{d}_g_o <= \"#{line.split.last}\";"
    end.join("\n").strip
    <<-end
  d#{d}_g: process(d#{d}_g_i) begin
    d#{d}_g_o <= (others => '-');
    if    std_match(d#{d}_g_i, "#{fline.first}") then d#{d}_g_o <= "#{fline.last}";
    #{el_if}
    end if;
  end process;
    end
  end

  def g_blocks
    decs.map.with_index { |_, d| g_block d }.join("\n").strip
  end

  def h_block
    lines = decs.last.h_kiss.lines.to_a
    fline = lines.shift.split
    el_if = lines.map do |line|
      parts = line.split
      "    elsif std_match(d#{decs.size - 1}_h_i, \"#{parts[0]}#{parts[1]}\") then d#{decs.size - 1}_h_o <= \"#{parts[2]}#{parts[3]}\";"
    end.join("\n").strip
    <<-end
  d#{decs.size - 1}_h: process(d#{decs.size - 1}_h_i) begin
    d#{decs.size - 1}_h_o <= (others => '-');
    if    std_match(d#{decs.size - 1}_h_i, "#{fline[0]}#{fline[1]}") then d#{decs.size - 1}_h_o <= "#{fline[2]}#{fline[3]}";
    #{el_if}
    end if;
  end process;
    end
  end

  def first_state
    encoded = ''
    code = nil
    decs.each.with_index do |dec, i|
      codes = Hash[dec.fsm.beta_q.ints.sort.map { |row| [dec.fsm.q_encoding(row), { qu: dec.qu.encoding(row), qv: dec.qv.encoding(row) }] }]
      code ||= codes.keys.first
      encoded.prepend codes[code][:qv]
      encoded.prepend codes[code][:qu] if i == decs.size - 1
      code = codes[code][:qu]
    end
    encoded
  end

  def signal_d d
    <<-end
  signal d#{d}_x:   std_logic_vector(0 to #{decs[d].fsm.input_count - 1});
  signal d#{d}_q:   std_logic_vector(0 to #{state_pins(d) - 1});
  signal d#{d}_qu:  std_logic_vector(0 to #{state_pins(d) - decs[d].qv.pins - 1});
  signal d#{d}_qv:  std_logic_vector(0 to #{decs[d].qv.pins - 1});
  signal d#{d}_g_i: std_logic_vector(0 to #{decs[d].v.size + decs[d].qv.pins - 1});
  signal d#{d}_g_o: std_logic_vector(0 to #{decs[d].g.pins - 1});
    end
  end

  def signals_d
    decs.map.with_index { |_, d| signal_d d }.join("\n").strip
  end

  def state_pins start = 0
    decs[start..-1].map { |d| d.qv.pins }.inject(:+) + decs.last.qu.pins
  end

  def structure_d d
    <<-end
  d#{d}_x   <= #{d.zero? ? 'fsm_i' : "(#{decs[d - 1].u.sort.map { |i| "d#{d - 1}_x(#{i})" }.join ' & '} & d#{d - 1}_g_o)"};
  d#{d}_q   <= #{d.zero? ? 'fsm_q' : "d#{d - 1}_qu"};

  d#{d}_qu  <= d#{d}_q(0 to #{state_pins(d) - decs[d].qv.pins - 1});
  d#{d}_qv  <= d#{d}_q(#{state_pins(d) - decs[d].qv.pins} to #{state_pins(d) - 1});

  d#{d}_g_i <= (#{decs[d].v.sort.map { |i| "d#{d}_x(#{i})" }.join ' & '} & d#{d}_qv);
    end
  end

  def structures_d
    decs.map.with_index { |_, d| structure_d d }.join("\n").strip
  end
end end
