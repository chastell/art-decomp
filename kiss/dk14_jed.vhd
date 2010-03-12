library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity dk14_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(2 downto 0);
    output: out std_logic_vector(4 downto 0)
  );
end dk14_jed;
architecture behaviour of dk14_jed is
  constant state_1: std_logic_vector(2 downto 0) := "010";
  constant state_3: std_logic_vector(2 downto 0) := "100";
  constant state_2: std_logic_vector(2 downto 0) := "000";
  constant state_4: std_logic_vector(2 downto 0) := "001";
  constant state_5: std_logic_vector(2 downto 0) := "110";
  constant state_6: std_logic_vector(2 downto 0) := "101";
  constant state_7: std_logic_vector(2 downto 0) := "111";
  signal current_state, next_state: std_logic_vector(2 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---"; output <= "-----";
    case current_state is
      when state_1 =>
        if std_match(input, "000") then next_state <= state_3; output <= "00010";
        elsif std_match(input, "100") then next_state <= state_4; output <= "00010";
        elsif std_match(input, "111") then next_state <= state_3; output <= "01010";
        elsif std_match(input, "110") then next_state <= state_4; output <= "01010";
        elsif std_match(input, "011") then next_state <= state_3; output <= "01000";
        elsif std_match(input, "001") then next_state <= state_5; output <= "00010";
        elsif std_match(input, "101") then next_state <= state_5; output <= "01010";
        elsif std_match(input, "010") then next_state <= state_6; output <= "01000";
        end if;
      when state_2 =>
        if std_match(input, "000") then next_state <= state_1; output <= "01001";
        elsif std_match(input, "100") then next_state <= state_2; output <= "01001";
        elsif std_match(input, "111") then next_state <= state_3; output <= "00100";
        elsif std_match(input, "110") then next_state <= state_5; output <= "00100";
        elsif std_match(input, "011") then next_state <= state_2; output <= "00101";
        elsif std_match(input, "001") then next_state <= state_1; output <= "00101";
        elsif std_match(input, "101") then next_state <= state_1; output <= "00001";
        elsif std_match(input, "010") then next_state <= state_2; output <= "00001";
        end if;
      when state_3 =>
        if std_match(input, "000") then next_state <= state_3; output <= "10010";
        elsif std_match(input, "100") then next_state <= state_4; output <= "10010";
        elsif std_match(input, "111") then next_state <= state_3; output <= "01010";
        elsif std_match(input, "110") then next_state <= state_4; output <= "01010";
        elsif std_match(input, "011") then next_state <= state_3; output <= "01000";
        elsif std_match(input, "001") then next_state <= state_5; output <= "10010";
        elsif std_match(input, "101") then next_state <= state_5; output <= "01010";
        elsif std_match(input, "010") then next_state <= state_6; output <= "01000";
        end if;
      when state_4 =>
        if std_match(input, "000") then next_state <= state_3; output <= "00010";
        elsif std_match(input, "100") then next_state <= state_4; output <= "00010";
        elsif std_match(input, "111") then next_state <= state_3; output <= "00100";
        elsif std_match(input, "110") then next_state <= state_5; output <= "00100";
        elsif std_match(input, "011") then next_state <= state_3; output <= "10100";
        elsif std_match(input, "001") then next_state <= state_5; output <= "00010";
        elsif std_match(input, "101") then next_state <= state_5; output <= "10100";
        elsif std_match(input, "010") then next_state <= state_7; output <= "10000";
        end if;
      when state_5 =>
        if std_match(input, "000") then next_state <= state_1; output <= "01001";
        elsif std_match(input, "100") then next_state <= state_2; output <= "01001";
        elsif std_match(input, "111") then next_state <= state_1; output <= "10001";
        elsif std_match(input, "110") then next_state <= state_1; output <= "10101";
        elsif std_match(input, "011") then next_state <= state_2; output <= "00101";
        elsif std_match(input, "001") then next_state <= state_1; output <= "00101";
        elsif std_match(input, "101") then next_state <= state_2; output <= "10001";
        elsif std_match(input, "010") then next_state <= state_2; output <= "10101";
        end if;
      when state_6 =>
        if std_match(input, "000") then next_state <= state_1; output <= "01001";
        elsif std_match(input, "100") then next_state <= state_2; output <= "01001";
        elsif std_match(input, "111") then next_state <= state_1; output <= "10001";
        elsif std_match(input, "110") then next_state <= state_1; output <= "10101";
        elsif std_match(input, "011") then next_state <= state_3; output <= "10100";
        elsif std_match(input, "001") then next_state <= state_5; output <= "10100";
        elsif std_match(input, "101") then next_state <= state_2; output <= "10001";
        elsif std_match(input, "010") then next_state <= state_2; output <= "10101";
        end if;
      when state_7 =>
        if std_match(input, "000") then next_state <= state_3; output <= "10010";
        elsif std_match(input, "100") then next_state <= state_4; output <= "10010";
        elsif std_match(input, "111") then next_state <= state_1; output <= "10001";
        elsif std_match(input, "110") then next_state <= state_1; output <= "10101";
        elsif std_match(input, "011") then next_state <= state_3; output <= "10100";
        elsif std_match(input, "001") then next_state <= state_5; output <= "10010";
        elsif std_match(input, "101") then next_state <= state_2; output <= "10001";
        elsif std_match(input, "010") then next_state <= state_2; output <= "10101";
        end if;
      when others => next_state <= "---"; output <= "-----";
    end case;
  end process;
end behaviour;
