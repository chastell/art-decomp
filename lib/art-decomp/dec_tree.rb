module ArtDecomp class DecTree
  attr_accessor :archs, :decs, :fsm

  def initialize decs, archs
    self.archs = archs
    self.decs  = decs
    self.fsm   = decs.first.fsm
  end

  def cells
    decs.map { |d| d.g_cells(archs) }.inject(:+) + decs.last.h_cells(archs) rescue nil
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

  signal d#{max_d}_h_i: std_logic_vector(0 to #{decs.last.u.size + decs.last.qu.pins + decs.last.g.pins - 1});
  signal d#{max_d}_h_o: std_logic_vector(0 to #{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - 1});

begin

  #{structures_d}

  d#{max_d}_h_i <= (#{h_inputs.join ' & '});

  fsm_qp <= d#{max_d}_h_o(0 to #{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - fsm.output_count - 1});
  fsm_o  <= d#{max_d}_h_o(#{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - fsm.output_count} to #{decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - 1});

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
    dec = decs[d]
    lines = (dec.fsm.beta_x(dec.v) * dec.qv).ints.map do |row|
      v  = dec.fsm.x_encoding dec.v, row
      qv = dec.qv.encoding row
      g  = dec.g.encoding row
      "    elsif std_match(d#{d}_g_i, \"#{v}#{qv}\") then d#{d}_g_o <= \"#{g}\";" unless g =~ /\A-+\Z/
    end.compact.sort.join("\n").gsub(/\A    elsif/, 'if   ')

    <<-end
  d#{d}_g: process(d#{d}_g_i) begin
    d#{d}_g_o <= (others => '-');
    #{lines}
    end if;
  end process;
    end
  end

  def g_blocks
    decs.map.with_index { |_, d| g_block d }.join("\n").strip
  end

  def g_inputs d
    decs[d].v.sort.map { |i| "d#{d}_x(#{i})" } + ["d#{d}_qv"]
  end

  def h_block
    dec = decs.last
    lines = (dec.fsm.beta_x(dec.u) * dec.g * dec.qu).ints.map do |row|
      u   = dec.fsm.x_encoding dec.u, row
      qu  = dec.qu.encoding row
      qup = dec.qu.encoding dec.fsm.state_rows_of_next_state_of(row)
      qvp = dec.qv.encoding dec.fsm.state_rows_of_next_state_of(row)
      y   = dec.fsm.y_encoding row
      dec.g.encodings(row).map do |g|
        "    elsif std_match(d#{max_d}_h_i, \"#{u}#{g}#{qu}\") then d#{max_d}_h_o <= \"#{qup}#{qvp}#{y}\";" unless "#{qup}#{qvp}#{y}" =~ /\A-+\Z/
      end
    end.flatten.compact.sort.join("\n").gsub(/\A    elsif/, 'if   ')

    <<-end
  d#{max_d}_h: process(d#{max_d}_h_i) begin
    d#{max_d}_h_o <= (others => '-');
    #{lines}
    end if;
  end process;
    end
  end

  def h_inputs
    decs.last.u.sort.map { |i| "d#{max_d}_x(#{i})" } + ["d#{max_d}_g_o", "d#{max_d}_qu"]
  end

  def first_state
    encoded = ''
    code = nil
    decs.each.with_index do |dec, i|
      codes = Hash[dec.fsm.beta_q.ints.sort.map { |row| [dec.fsm.q_encoding(row), { qu: dec.qu.encoding(row), qv: dec.qv.encoding(row) }] }]
      code ||= codes.keys.first
      encoded.prepend codes[code][:qv]
      encoded.prepend codes[code][:qu] if i == max_d
      code = codes[code][:qu]
      break if code.empty?
    end
    encoded
  end

  def max_d
    decs.size - 1
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

  d#{d}_g_i <= (#{g_inputs(d).join ' & '});
    end
  end

  def structures_d
    decs.map.with_index { |_, d| structure_d d }.join("\n").strip
  end
end end
