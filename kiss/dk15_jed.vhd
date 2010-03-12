library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity dk15_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(2 downto 0);
    output: out std_logic_vector(4 downto 0)
  );
end dk15_jed;
architecture behaviour of dk15_jed is
  constant state1: std_logic_vector(1 downto 0) := "01";
  constant state2: std_logic_vector(1 downto 0) := "00";
  constant state3: std_logic_vector(1 downto 0) := "10";
  constant state4: std_logic_vector(1 downto 0) := "11";
  signal current_state, next_state: std_logic_vector(1 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "--"; output <= "-----";
    case current_state is
      when state1 =>
        if std_match(input, "000") then next_state <= state1; output <= "00101";
        elsif std_match(input, "001") then next_state <= state2; output <= "00010";
        elsif std_match(input, "010") then next_state <= state3; output <= "00010";
        elsif std_match(input, "011") then next_state <= state2; output <= "10001";
        elsif std_match(input, "111") then next_state <= state3; output <= "10101";
        elsif std_match(input, "100") then next_state <= state1; output <= "01001";
        elsif std_match(input, "101") then next_state <= state2; output <= "01010";
        elsif std_match(input, "110") then next_state <= state3; output <= "01010";
        end if;
      when state2 =>
        if std_match(input, "000") then next_state <= state2; output <= "10010";
        elsif std_match(input, "001") then next_state <= state2; output <= "10100";
        elsif std_match(input, "010") then next_state <= state3; output <= "10010";
        elsif std_match(input, "011") then next_state <= state2; output <= "10001";
        elsif std_match(input, "111") then next_state <= state3; output <= "10101";
        elsif std_match(input, "100") then next_state <= state3; output <= "01001";
        elsif std_match(input, "101") then next_state <= state2; output <= "01010";
        elsif std_match(input, "110") then next_state <= state3; output <= "01010";
        end if;
      when state3 =>
        if std_match(input, "000") then next_state <= state1; output <= "00101";
        elsif std_match(input, "001") then next_state <= state2; output <= "00010";
        elsif std_match(input, "010") then next_state <= state3; output <= "00010";
        elsif std_match(input, "011") then next_state <= state1; output <= "00100";
        elsif std_match(input, "111") then next_state <= state1; output <= "00100";
        elsif std_match(input, "100") then next_state <= state1; output <= "10100";
        elsif std_match(input, "101") then next_state <= state2; output <= "01000";
        elsif std_match(input, "110") then next_state <= state4; output <= "01010";
        end if;
      when state4 =>
        if std_match(input, "000") then next_state <= state2; output <= "10010";
        elsif std_match(input, "001") then next_state <= state2; output <= "10100";
        elsif std_match(input, "010") then next_state <= state3; output <= "10010";
        elsif std_match(input, "011") then next_state <= state1; output <= "00100";
        elsif std_match(input, "111") then next_state <= state1; output <= "00100";
        elsif std_match(input, "100") then next_state <= state1; output <= "01001";
        elsif std_match(input, "101") then next_state <= state2; output <= "01010";
        elsif std_match(input, "110") then next_state <= state3; output <= "10000";
        end if;
      when others => next_state <= "--"; output <= "-----";
    end case;
  end process;
end behaviour;
