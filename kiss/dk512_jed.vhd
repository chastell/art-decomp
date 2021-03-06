library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity dk512_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(0 downto 0);
    output: out std_logic_vector(2 downto 0)
  );
end dk512_jed;
architecture behaviour of dk512_jed is
  constant state_1: std_logic_vector(3 downto 0) := "1001";
  constant state_8: std_logic_vector(3 downto 0) := "0011";
  constant state_2: std_logic_vector(3 downto 0) := "1101";
  constant state_4: std_logic_vector(3 downto 0) := "0001";
  constant state_3: std_logic_vector(3 downto 0) := "0101";
  constant state_5: std_logic_vector(3 downto 0) := "0000";
  constant state_6: std_logic_vector(3 downto 0) := "0100";
  constant state_13: std_logic_vector(3 downto 0) := "0010";
  constant state_7: std_logic_vector(3 downto 0) := "1100";
  constant state_9: std_logic_vector(3 downto 0) := "0111";
  constant state_10: std_logic_vector(3 downto 0) := "1010";
  constant state_11: std_logic_vector(3 downto 0) := "0110";
  constant state_12: std_logic_vector(3 downto 0) := "1111";
  constant state_14: std_logic_vector(3 downto 0) := "1110";
  constant state_15: std_logic_vector(3 downto 0) := "1000";
  signal current_state, next_state: std_logic_vector(3 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "----"; output <= "---";
    case current_state is
      when state_1 =>
        if std_match(input, "0") then next_state <= state_8; output <= "000";
        elsif std_match(input, "1") then next_state <= state_9; output <= "000";
        end if;
      when state_2 =>
        if std_match(input, "0") then next_state <= state_4; output <= "000";
        elsif std_match(input, "1") then next_state <= state_3; output <= "000";
        end if;
      when state_3 =>
        if std_match(input, "0") then next_state <= state_5; output <= "000";
        elsif std_match(input, "1") then next_state <= state_6; output <= "000";
        end if;
      when state_4 =>
        if std_match(input, "0") then next_state <= state_8; output <= "000";
        elsif std_match(input, "1") then next_state <= state_11; output <= "000";
        end if;
      when state_5 =>
        if std_match(input, "0") then next_state <= state_8; output <= "000";
        elsif std_match(input, "1") then next_state <= state_12; output <= "000";
        end if;
      when state_6 =>
        if std_match(input, "0") then next_state <= state_13; output <= "000";
        elsif std_match(input, "1") then next_state <= state_14; output <= "000";
        end if;
      when state_7 =>
        if std_match(input, "0") then next_state <= state_4; output <= "000";
        elsif std_match(input, "1") then next_state <= state_15; output <= "000";
        end if;
      when state_8 =>
        if std_match(input, "0") then next_state <= state_1; output <= "001";
        elsif std_match(input, "1") then next_state <= state_2; output <= "001";
        end if;
      when state_9 =>
        if std_match(input, "0") then next_state <= state_4; output <= "000";
        elsif std_match(input, "1") then next_state <= state_3; output <= "001";
        end if;
      when state_10 =>
        if std_match(input, "0") then next_state <= state_1; output <= "010";
        elsif std_match(input, "1") then next_state <= state_2; output <= "010";
        end if;
      when state_11 =>
        if std_match(input, "0") then next_state <= state_3; output <= "010";
        elsif std_match(input, "1") then next_state <= state_4; output <= "010";
        end if;
      when state_12 =>
        if std_match(input, "0") then next_state <= state_4; output <= "100";
        elsif std_match(input, "1") then next_state <= state_3; output <= "001";
        end if;
      when state_13 =>
        if std_match(input, "0") then next_state <= state_5; output <= "100";
        elsif std_match(input, "1") then next_state <= state_6; output <= "100";
        end if;
      when state_14 =>
        if std_match(input, "0") then next_state <= state_3; output <= "100";
        elsif std_match(input, "1") then next_state <= state_7; output <= "100";
        end if;
      when state_15 =>
        if std_match(input, "0") then next_state <= state_4; output <= "000";
        elsif std_match(input, "1") then next_state <= state_6; output <= "000";
        end if;
      when others => next_state <= "----"; output <= "---";
    end case;
  end process;
end behaviour;
