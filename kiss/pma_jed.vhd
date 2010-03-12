library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity pma_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(7 downto 0);
    output: out std_logic_vector(7 downto 0)
  );
end pma_jed;
architecture behaviour of pma_jed is
  constant s0: std_logic_vector(4 downto 0) := "01010";
  constant s1: std_logic_vector(4 downto 0) := "01001";
  constant s21: std_logic_vector(4 downto 0) := "01100";
  constant s2: std_logic_vector(4 downto 0) := "01111";
  constant s3: std_logic_vector(4 downto 0) := "01011";
  constant s4: std_logic_vector(4 downto 0) := "10110";
  constant s6: std_logic_vector(4 downto 0) := "00110";
  constant s7: std_logic_vector(4 downto 0) := "10010";
  constant s5: std_logic_vector(4 downto 0) := "00011";
  constant s10: std_logic_vector(4 downto 0) := "01110";
  constant s8: std_logic_vector(4 downto 0) := "00101";
  constant s9: std_logic_vector(4 downto 0) := "00111";
  constant s11: std_logic_vector(4 downto 0) := "11010";
  constant s12: std_logic_vector(4 downto 0) := "11000";
  constant s13: std_logic_vector(4 downto 0) := "11110";
  constant s14: std_logic_vector(4 downto 0) := "10011";
  constant s22: std_logic_vector(4 downto 0) := "01000";
  constant s30: std_logic_vector(4 downto 0) := "00010";
  constant s23: std_logic_vector(4 downto 0) := "10000";
  constant s25: std_logic_vector(4 downto 0) := "00000";
  constant s24: std_logic_vector(4 downto 0) := "00100";
  constant s26: std_logic_vector(4 downto 0) := "00001";
  constant s27: std_logic_vector(4 downto 0) := "10001";
  constant s28: std_logic_vector(4 downto 0) := "10100";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "--------";
    case current_state is
      when s0 =>
        if std_match(input, "----1---") then next_state <= s1; output <= "00000000";
        elsif std_match(input, "1---01--") then next_state <= s21; output <= "00000000";
        end if;
      when s1 =>
        if std_match(input, "---0---1") then next_state <= s2; output <= "00001000";
        elsif std_match(input, "---0--1-") then next_state <= s2; output <= "00001000";
        elsif std_match(input, "1--1----") then next_state <= s3; output <= "00001000";
        end if;
      when s2 =>
        if std_match(input, "1--1----") then next_state <= s3; output <= "00000100";
        end if;
      when s3 =>
        if std_match(input, "1--1----") then next_state <= s4; output <= "10000000";
        elsif std_match(input, "1--0---1") then next_state <= s6; output <= "10000000";
        elsif std_match(input, "1--0--1-") then next_state <= s6; output <= "10000000";
        elsif std_match(input, "1--0--00") then next_state <= s7; output <= "10000000";
        end if;
      when s4 =>
        if std_match(input, "1--1----") then next_state <= s5; output <= "01000000";
        elsif std_match(input, "1--0---1") then next_state <= s6; output <= "01000000";
        elsif std_match(input, "1--0--1-") then next_state <= s6; output <= "01000000";
        elsif std_match(input, "1--0--00") then next_state <= s7; output <= "01000000";
        end if;
      when s5 =>
        if std_match(input, "1--1----") then next_state <= s5; output <= "11000000";
        elsif std_match(input, "1--0---1") then next_state <= s6; output <= "11000000";
        elsif std_match(input, "1--0--1-") then next_state <= s6; output <= "11000000";
        elsif std_match(input, "1--0--00") then next_state <= s7; output <= "11000000";
        end if;
      when s6 =>
        if std_match(input, "1-----01") then next_state <= s0; output <= "00100000";
        elsif std_match(input, "1-----1-") then next_state <= s10; output <= "00100000";
        end if;
      when s7 =>
        if std_match(input, "-1--1---") then next_state <= s8; output <= "11101010";
        elsif std_match(input, "-1--0--1") then next_state <= s6; output <= "11101010";
        elsif std_match(input, "-1--0-1-") then next_state <= s6; output <= "11101010";
        end if;
      when s8 =>
        if std_match(input, "1--1----") then next_state <= s5; output <= "01110000";
        elsif std_match(input, "---0---1") then next_state <= s9; output <= "01110000";
        elsif std_match(input, "---0--1-") then next_state <= s9; output <= "01110000";
        end if;
      when s9 =>
        if std_match(input, "1--1----") then next_state <= s5; output <= "11100100";
        end if;
      when s10 =>
        if std_match(input, "1--10--0") then next_state <= s11; output <= "10101100";
        elsif std_match(input, "1------1") then next_state <= s0; output <= "10101100";
        elsif std_match(input, "1---1---") then next_state <= s0; output <= "10101100";
        end if;
      when s11 =>
        if std_match(input, "-11-0--0") then next_state <= s12; output <= "11111101";
        elsif std_match(input, "11-----1") then next_state <= s0; output <= "11111101";
        elsif std_match(input, "1---1---") then next_state <= s0; output <= "11111101";
        end if;
      when s12 =>
        if std_match(input, "---00--0") then next_state <= s13; output <= "10111100";
        elsif std_match(input, "1------1") then next_state <= s0; output <= "10111100";
        elsif std_match(input, "1---1---") then next_state <= s0; output <= "10111100";
        end if;
      when s13 =>
        if std_match(input, "1-------") then next_state <= s14; output <= "11111100";
        end if;
      when s14 =>
        if std_match(input, "1---0--0") then next_state <= s10; output <= "01100000";
        elsif std_match(input, "1------1") then next_state <= s0; output <= "01100000";
        elsif std_match(input, "1---1---") then next_state <= s0; output <= "01100000";
        end if;
      when s21 =>
        if std_match(input, "1---0-00") then next_state <= s22; output <= "00011100";
        elsif std_match(input, "1---1---") then next_state <= s30; output <= "00011100";
        elsif std_match(input, "1-----1-") then next_state <= s30; output <= "00011100";
        elsif std_match(input, "1------1") then next_state <= s30; output <= "00011100";
        end if;
      when s22 =>
        if std_match(input, "1---0100") then next_state <= s23; output <= "10011100";
        elsif std_match(input, "1---0000") then next_state <= s25; output <= "10011100";
        elsif std_match(input, "1---1---") then next_state <= s30; output <= "10011100";
        elsif std_match(input, "1-----1-") then next_state <= s30; output <= "10011100";
        elsif std_match(input, "1------1") then next_state <= s30; output <= "10011100";
        end if;
      when s23 =>
        if std_match(input, "1---0100") then next_state <= s24; output <= "01011100";
        elsif std_match(input, "1---0000") then next_state <= s25; output <= "01011100";
        elsif std_match(input, "1---1---") then next_state <= s30; output <= "01011100";
        elsif std_match(input, "1-----1-") then next_state <= s30; output <= "01011100";
        elsif std_match(input, "1------1") then next_state <= s30; output <= "01011100";
        end if;
      when s24 =>
        if std_match(input, "1---0000") then next_state <= s25; output <= "11011100";
        elsif std_match(input, "1---1---") then next_state <= s30; output <= "11011100";
        elsif std_match(input, "1-----1-") then next_state <= s30; output <= "11011100";
        elsif std_match(input, "1------1") then next_state <= s30; output <= "11011100";
        end if;
      when s25 =>
        if std_match(input, "---10-00") then next_state <= s26; output <= "01111100";
        elsif std_match(input, "1---1---") then next_state <= s30; output <= "01111100";
        elsif std_match(input, "1-----1-") then next_state <= s30; output <= "01111100";
        elsif std_match(input, "1------1") then next_state <= s30; output <= "01111100";
        end if;
      when s26 =>
        if std_match(input, "011---00") then next_state <= s27; output <= "01111101";
        elsif std_match(input, "1---1---") then next_state <= s30; output <= "01111101";
        elsif std_match(input, "1-----1-") then next_state <= s30; output <= "01111101";
        elsif std_match(input, "1------1") then next_state <= s30; output <= "01111101";
        end if;
      when s27 =>
        if std_match(input, "0--00-00") then next_state <= s28; output <= "11101100";
        elsif std_match(input, "1--00-00") then next_state <= s0; output <= "11101100";
        elsif std_match(input, "1---1---") then next_state <= s30; output <= "11101100";
        elsif std_match(input, "1-----1-") then next_state <= s30; output <= "11101100";
        elsif std_match(input, "1------1") then next_state <= s30; output <= "11101100";
        end if;
      when s28 =>
        if std_match(input, "1-------") then next_state <= s0; output <= "10111000";
        end if;
      when s30 =>
        if std_match(input, "1-------") then next_state <= s0; output <= "00110000";
        end if;
      when others => next_state <= "-----"; output <= "--------";
    end case;
  end process;
end behaviour;
