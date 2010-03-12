library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity dk16_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(2 downto 0)
  );
end dk16_jed;
architecture behaviour of dk16_jed is
  constant state_1: std_logic_vector(4 downto 0) := "11000";
  constant state_3: std_logic_vector(4 downto 0) := "11100";
  constant state_2: std_logic_vector(4 downto 0) := "01000";
  constant state_4: std_logic_vector(4 downto 0) := "01010";
  constant state_5: std_logic_vector(4 downto 0) := "01001";
  constant state_6: std_logic_vector(4 downto 0) := "11011";
  constant state_7: std_logic_vector(4 downto 0) := "11001";
  constant state_9: std_logic_vector(4 downto 0) := "11010";
  constant state_8: std_logic_vector(4 downto 0) := "10010";
  constant state_15: std_logic_vector(4 downto 0) := "11110";
  constant state_10: std_logic_vector(4 downto 0) := "10100";
  constant state_14: std_logic_vector(4 downto 0) := "11101";
  constant state_11: std_logic_vector(4 downto 0) := "10110";
  constant state_12: std_logic_vector(4 downto 0) := "10000";
  constant state_20: std_logic_vector(4 downto 0) := "01110";
  constant state_13: std_logic_vector(4 downto 0) := "11111";
  constant state_16: std_logic_vector(4 downto 0) := "10011";
  constant state_17: std_logic_vector(4 downto 0) := "10001";
  constant state_18: std_logic_vector(4 downto 0) := "01111";
  constant state_19: std_logic_vector(4 downto 0) := "01100";
  constant state_21: std_logic_vector(4 downto 0) := "00100";
  constant state_22: std_logic_vector(4 downto 0) := "00101";
  constant state_23: std_logic_vector(4 downto 0) := "01101";
  constant state_24: std_logic_vector(4 downto 0) := "10111";
  constant state_25: std_logic_vector(4 downto 0) := "10101";
  constant state_26: std_logic_vector(4 downto 0) := "01011";
  constant state_27: std_logic_vector(4 downto 0) := "00111";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "---";
    case current_state is
      when state_1 =>
        if std_match(input, "00") then next_state <= state_3; output <= "001";
        elsif std_match(input, "01") then next_state <= state_10; output <= "001";
        elsif std_match(input, "10") then next_state <= state_11; output <= "001";
        elsif std_match(input, "11") then next_state <= state_12; output <= "001";
        end if;
      when state_2 =>
        if std_match(input, "00") then next_state <= state_1; output <= "001";
        elsif std_match(input, "01") then next_state <= state_2; output <= "001";
        elsif std_match(input, "10") then next_state <= state_8; output <= "001";
        elsif std_match(input, "11") then next_state <= state_9; output <= "001";
        end if;
      when state_3 =>
        if std_match(input, "00") then next_state <= state_4; output <= "001";
        elsif std_match(input, "01") then next_state <= state_5; output <= "001";
        elsif std_match(input, "10") then next_state <= state_6; output <= "001";
        elsif std_match(input, "11") then next_state <= state_7; output <= "001";
        end if;
      when state_4 =>
        if std_match(input, "00") then next_state <= state_4; output <= "010";
        elsif std_match(input, "01") then next_state <= state_5; output <= "010";
        elsif std_match(input, "10") then next_state <= state_6; output <= "010";
        elsif std_match(input, "11") then next_state <= state_7; output <= "010";
        end if;
      when state_5 =>
        if std_match(input, "00") then next_state <= state_1; output <= "010";
        elsif std_match(input, "01") then next_state <= state_2; output <= "010";
        elsif std_match(input, "10") then next_state <= state_16; output <= "010";
        elsif std_match(input, "11") then next_state <= state_17; output <= "010";
        end if;
      when state_6 =>
        if std_match(input, "00") then next_state <= state_3; output <= "010";
        elsif std_match(input, "01") then next_state <= state_21; output <= "010";
        elsif std_match(input, "10") then next_state <= state_10; output <= "010";
        elsif std_match(input, "11") then next_state <= state_22; output <= "010";
        end if;
      when state_7 =>
        if std_match(input, "00") then next_state <= state_9; output <= "010";
        elsif std_match(input, "01") then next_state <= state_18; output <= "010";
        elsif std_match(input, "10") then next_state <= state_19; output <= "010";
        elsif std_match(input, "11") then next_state <= state_20; output <= "010";
        end if;
      when state_8 =>
        if std_match(input, "00") then next_state <= state_15; output <= "010";
        elsif std_match(input, "01") then next_state <= state_26; output <= "000";
        elsif std_match(input, "10") then next_state <= state_13; output <= "010";
        elsif std_match(input, "11") then next_state <= state_14; output <= "010";
        end if;
      when state_9 =>
        if std_match(input, "00") then next_state <= state_1; output <= "000";
        elsif std_match(input, "01") then next_state <= state_5; output <= "000";
        elsif std_match(input, "10") then next_state <= state_6; output <= "000";
        elsif std_match(input, "11") then next_state <= state_7; output <= "000";
        end if;
      when state_10 =>
        if std_match(input, "00") then next_state <= state_14; output <= "000";
        elsif std_match(input, "01") then next_state <= state_13; output <= "000";
        elsif std_match(input, "10") then next_state <= state_1; output <= "000";
        elsif std_match(input, "11") then next_state <= state_2; output <= "000";
        end if;
      when state_11 =>
        if std_match(input, "00") then next_state <= state_3; output <= "000";
        elsif std_match(input, "01") then next_state <= state_23; output <= "000";
        elsif std_match(input, "10") then next_state <= state_24; output <= "000";
        elsif std_match(input, "11") then next_state <= state_25; output <= "000";
        end if;
      when state_12 =>
        if std_match(input, "00") then next_state <= state_20; output <= "000";
        elsif std_match(input, "01") then next_state <= state_19; output <= "000";
        elsif std_match(input, "10") then next_state <= state_18; output <= "000";
        elsif std_match(input, "11") then next_state <= state_15; output <= "000";
        end if;
      when state_13 =>
        if std_match(input, "00") then next_state <= state_3; output <= "101";
        elsif std_match(input, "01") then next_state <= state_10; output <= "101";
        elsif std_match(input, "10") then next_state <= state_11; output <= "101";
        elsif std_match(input, "11") then next_state <= state_12; output <= "101";
        end if;
      when state_14 =>
        if std_match(input, "00") then next_state <= state_1; output <= "101";
        elsif std_match(input, "01") then next_state <= state_2; output <= "101";
        elsif std_match(input, "10") then next_state <= state_8; output <= "101";
        elsif std_match(input, "11") then next_state <= state_9; output <= "101";
        end if;
      when state_15 =>
        if std_match(input, "00") then next_state <= state_4; output <= "101";
        elsif std_match(input, "01") then next_state <= state_5; output <= "101";
        elsif std_match(input, "10") then next_state <= state_6; output <= "101";
        elsif std_match(input, "11") then next_state <= state_7; output <= "101";
        end if;
      when state_16 =>
        if std_match(input, "00") then next_state <= state_20; output <= "000";
        elsif std_match(input, "01") then next_state <= state_19; output <= "000";
        elsif std_match(input, "10") then next_state <= state_13; output <= "010";
        elsif std_match(input, "11") then next_state <= state_14; output <= "010";
        end if;
      when state_17 =>
        if std_match(input, "00") then next_state <= state_15; output <= "010";
        elsif std_match(input, "01") then next_state <= state_23; output <= "000";
        elsif std_match(input, "10") then next_state <= state_18; output <= "000";
        elsif std_match(input, "11") then next_state <= state_27; output <= "000";
        end if;
      when state_18 =>
        if std_match(input, "00") then next_state <= state_4; output <= "100";
        elsif std_match(input, "01") then next_state <= state_5; output <= "010";
        elsif std_match(input, "10") then next_state <= state_6; output <= "100";
        elsif std_match(input, "11") then next_state <= state_7; output <= "100";
        end if;
      when state_19 =>
        if std_match(input, "00") then next_state <= state_18; output <= "100";
        elsif std_match(input, "01") then next_state <= state_23; output <= "010";
        elsif std_match(input, "10") then next_state <= state_24; output <= "100";
        elsif std_match(input, "11") then next_state <= state_25; output <= "100";
        end if;
      when state_20 =>
        if std_match(input, "00") then next_state <= state_19; output <= "100";
        elsif std_match(input, "01") then next_state <= state_20; output <= "010";
        elsif std_match(input, "10") then next_state <= state_9; output <= "100";
        elsif std_match(input, "11") then next_state <= state_26; output <= "100";
        end if;
      when state_21 =>
        if std_match(input, "00") then next_state <= state_2; output <= "100";
        elsif std_match(input, "01") then next_state <= state_1; output <= "010";
        elsif std_match(input, "10") then next_state <= state_13; output <= "100";
        elsif std_match(input, "11") then next_state <= state_14; output <= "100";
        end if;
      when state_22 =>
        if std_match(input, "00") then next_state <= state_3; output <= "000";
        elsif std_match(input, "01") then next_state <= state_3; output <= "010";
        elsif std_match(input, "10") then next_state <= state_15; output <= "100";
        elsif std_match(input, "11") then next_state <= state_15; output <= "000";
        end if;
      when state_23 =>
        if std_match(input, "00") then next_state <= state_2; output <= "100";
        elsif std_match(input, "01") then next_state <= state_1; output <= "010";
        elsif std_match(input, "10") then next_state <= state_13; output <= "010";
        elsif std_match(input, "11") then next_state <= state_14; output <= "010";
        end if;
      when state_24 =>
        if std_match(input, "00") then next_state <= state_14; output <= "000";
        elsif std_match(input, "01") then next_state <= state_13; output <= "000";
        elsif std_match(input, "10") then next_state <= state_13; output <= "100";
        elsif std_match(input, "11") then next_state <= state_14; output <= "100";
        end if;
      when state_25 =>
        if std_match(input, "00") then next_state <= state_15; output <= "010";
        elsif std_match(input, "01") then next_state <= state_3; output <= "010";
        elsif std_match(input, "10") then next_state <= state_15; output <= "000";
        elsif std_match(input, "11") then next_state <= state_15; output <= "000";
        end if;
      when state_26 =>
        if std_match(input, "00") then next_state <= state_20; output <= "000";
        elsif std_match(input, "01") then next_state <= state_19; output <= "000";
        elsif std_match(input, "10") then next_state <= state_18; output <= "000";
        elsif std_match(input, "11") then next_state <= state_21; output <= "000";
        end if;
      when state_27 =>
        if std_match(input, "00") then next_state <= state_15; output <= "010";
        elsif std_match(input, "01") then next_state <= state_3; output <= "010";
        elsif std_match(input, "10") then next_state <= state_13; output <= "100";
        elsif std_match(input, "11") then next_state <= state_14; output <= "100";
        end if;
      when others => next_state <= "-----"; output <= "---";
    end case;
  end process;
end behaviour;
