module ArtDecomp class VHDL

  def initialize fsm
    @fsm = fsm
  end

  def vhdl name
    structure = @fsm.structure
    logic = structure[DontCare].map do |input, results|
      [
        "    if std_match(input, \"#{input}\") then next_state <= #{results[:next_state]}; output <= \"#{results[:output]}\";",
        '    end if;',
      ]
    end
    structure.delete DontCare
    logic << '    case current_state is'
    logic += structure.map do |state, transitions|
      [
        "      when #{state} =>",
        transitions.map.with_index do |(input, results), i|
          "        #{'els' if i > 0}if std_match(input, \"#{input}\") then next_state <= #{results[:next_state]}; output <= \"#{results[:output]}\";"
        end,
        '        end if;',
      ]
    end
    logic << '    end case;'
    <<-VHDL
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity #{name} is
  port(
    clock:  in  std_logic;
    reset:  in  std_logic;
    input:  in  std_logic_vector(#{structure.first.last.first.first.size - 1} downto 0);
    output: out std_logic_vector(#{structure.first.last.first.last[:output].size - 1} downto 0)
  );
end #{name};
architecture behaviour of #{name} is
  type state is (#{structure.keys.join ', '});
  signal current_state, next_state: state;
begin
  process(clock, reset) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
#{logic.join "\n"}
  end process;
end behaviour;
    VHDL
  end

end end
