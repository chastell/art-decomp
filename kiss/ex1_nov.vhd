library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity ex1_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(8 downto 0);
    output: out std_logic_vector(18 downto 0)
  );
end ex1_nov;
architecture behaviour of ex1_nov is
  constant s1: std_logic_vector(4 downto 0) := "01000";
  constant s2: std_logic_vector(4 downto 0) := "10011";
  constant s3: std_logic_vector(4 downto 0) := "00111";
  constant s4: std_logic_vector(4 downto 0) := "00000";
  constant s5: std_logic_vector(4 downto 0) := "10000";
  constant s6: std_logic_vector(4 downto 0) := "11001";
  constant s7: std_logic_vector(4 downto 0) := "01111";
  constant s8: std_logic_vector(4 downto 0) := "10001";
  constant s9: std_logic_vector(4 downto 0) := "11010";
  constant s10: std_logic_vector(4 downto 0) := "11011";
  constant s11: std_logic_vector(4 downto 0) := "11100";
  constant s12: std_logic_vector(4 downto 0) := "11101";
  constant s13: std_logic_vector(4 downto 0) := "11000";
  constant s14: std_logic_vector(4 downto 0) := "11110";
  constant s15: std_logic_vector(4 downto 0) := "10100";
  constant s16: std_logic_vector(4 downto 0) := "11111";
  constant s17: std_logic_vector(4 downto 0) := "10101";
  constant s18: std_logic_vector(4 downto 0) := "10110";
  constant s19: std_logic_vector(4 downto 0) := "10111";
  constant s20: std_logic_vector(4 downto 0) := "10010";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "-------------------";
    case current_state is
      when s1 =>
        if std_match(input, "1011-----") then next_state <= s2; output <= "1111100000000000000";
        elsif std_match(input, "11-------") then next_state <= s4; output <= "0000000000000000000";
        elsif std_match(input, "1000-----") then next_state <= s3; output <= "1000011000000000000";
        elsif std_match(input, "1010-----") then next_state <= s1; output <= "1000000000000000000";
        elsif std_match(input, "1001-----") then next_state <= s2; output <= "1111100000000000000";
        end if;
      when s2 =>
        if std_match(input, "-1--1----") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--1----") then next_state <= s6; output <= "0001000000000000000";
        elsif std_match(input, "-0--0----") then next_state <= s2; output <= "0111100000000000000";
        end if;
      when s3 =>
        if std_match(input, "-0-------") then next_state <= s7; output <= "0111101010000000000";
        end if;
      when s4 =>
        if std_match(input, "-011-----") then next_state <= s2; output <= "1111100000000000000";
        elsif std_match(input, "-000-----") then next_state <= s3; output <= "1000011000000000000";
        elsif std_match(input, "-010-----") then next_state <= s1; output <= "1000000000000000000";
        elsif std_match(input, "-001-----") then next_state <= s2; output <= "1111100000000000000";
        end if;
      when s5 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "----100--") then next_state <= s5; output <= "0001000000000000000";
        elsif std_match(input, "----110--") then next_state <= s5; output <= "0001000001000000000";
        elsif std_match(input, "----101--") then next_state <= s8; output <= "0000000000000000000";
        elsif std_match(input, "----111--") then next_state <= s8; output <= "0000000001000000000";
        end if;
      when s6 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-00-11-1-") then next_state <= s9; output <= "0001101001111000000";
        elsif std_match(input, "-0--11-0-") then next_state <= s6; output <= "0001000001000000000";
        elsif std_match(input, "-01-11-1-") then next_state <= s10; output <= "0001100001111000000";
        elsif std_match(input, "-00-10-1-") then next_state <= s9; output <= "0001101000111000000";
        elsif std_match(input, "-0--10-0-") then next_state <= s6; output <= "0001000000000000000";
        elsif std_match(input, "-01-10-1-") then next_state <= s10; output <= "0001100000111000000";
        end if;
      when s7 =>
        if std_match(input, "-0--0----") then next_state <= s7; output <= "0111101000000000000";
        elsif std_match(input, "-1--1----") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-00-1----") then next_state <= s11; output <= "0001001000000000000";
        elsif std_match(input, "-01-1----") then next_state <= s12; output <= "0001000000000000000";
        end if;
      when s8 =>
        if std_match(input, "-----1---") then next_state <= s1; output <= "0000000001000110000";
        elsif std_match(input, "-----0---") then next_state <= s1; output <= "0000000000000110000";
        end if;
      when s9 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-01-11-1-") then next_state <= s13; output <= "0001100011001001000";
        elsif std_match(input, "-0--11-0-") then next_state <= s9; output <= "0001001001001000000";
        elsif std_match(input, "-00-11-1-") then next_state <= s14; output <= "0001101011001001000";
        elsif std_match(input, "-01-10-1-") then next_state <= s13; output <= "0001100010001001000";
        elsif std_match(input, "-0--10-0-") then next_state <= s9; output <= "0001001000001000000";
        elsif std_match(input, "-00-10-1-") then next_state <= s14; output <= "0001101010001001000";
        end if;
      when s10 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--11-1-") then next_state <= s15; output <= "0001100001001001000";
        elsif std_match(input, "-0--11-0-") then next_state <= s10; output <= "0001000001001000000";
        elsif std_match(input, "-0--10-1-") then next_state <= s15; output <= "0001100000001001000";
        elsif std_match(input, "-0--10-0-") then next_state <= s10; output <= "0001000000001000000";
        end if;
      when s11 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-00-11-11") then next_state <= s16; output <= "0001101011011000110";
        elsif std_match(input, "-00-11-0-") then next_state <= s11; output <= "0001001001000000000";
        elsif std_match(input, "-00-11-10") then next_state <= s16; output <= "0001101011011000010";
        elsif std_match(input, "-01-11-11") then next_state <= s13; output <= "0001100011011000110";
        elsif std_match(input, "-01-11-10") then next_state <= s13; output <= "0001100011011000010";
        elsif std_match(input, "-01-11-0-") then next_state <= s12; output <= "0001000001000000000";
        elsif std_match(input, "-00-10-11") then next_state <= s16; output <= "0001101010011000110";
        elsif std_match(input, "-00-10-0-") then next_state <= s11; output <= "0001001000000000000";
        elsif std_match(input, "-00-10-10") then next_state <= s16; output <= "0001101010011000010";
        elsif std_match(input, "-01-10-11") then next_state <= s13; output <= "0001100010011000110";
        elsif std_match(input, "-01-10-10") then next_state <= s13; output <= "0001100010011000010";
        elsif std_match(input, "-01-10-0-") then next_state <= s12; output <= "0001000000000000000";
        end if;
      when s12 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--11-11") then next_state <= s15; output <= "0001100001011000110";
        elsif std_match(input, "-0--11-0-") then next_state <= s12; output <= "0001000001000000000";
        elsif std_match(input, "-0--11-10") then next_state <= s15; output <= "0001100001011000010";
        elsif std_match(input, "-0--10-11") then next_state <= s15; output <= "0001100000011000110";
        elsif std_match(input, "-0--10-0-") then next_state <= s12; output <= "0001000000000000000";
        elsif std_match(input, "-0--10-10") then next_state <= s15; output <= "0001100000011000010";
        end if;
      when s13 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--11-11") then next_state <= s15; output <= "0001100001001000110";
        elsif std_match(input, "-0--11-0-") then next_state <= s13; output <= "0001000001001000000";
        elsif std_match(input, "-0--11-10") then next_state <= s15; output <= "0001100001001000010";
        elsif std_match(input, "-0--10-11") then next_state <= s15; output <= "0001100000001000110";
        elsif std_match(input, "-0--10-0-") then next_state <= s13; output <= "0001000000001000000";
        elsif std_match(input, "-0--10-10") then next_state <= s15; output <= "0001100000001000010";
        end if;
      when s14 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-00-11-11") then next_state <= s16; output <= "0001101011001000110";
        elsif std_match(input, "-0--11-0-") then next_state <= s14; output <= "0001001001001000000";
        elsif std_match(input, "-00-11-10") then next_state <= s16; output <= "0001101011001000010";
        elsif std_match(input, "-01-11-11") then next_state <= s13; output <= "0001100011001000110";
        elsif std_match(input, "-01-11-10") then next_state <= s13; output <= "0001100011001000010";
        elsif std_match(input, "-00-10-11") then next_state <= s16; output <= "0001101010001000110";
        elsif std_match(input, "-0--10-0-") then next_state <= s14; output <= "0001001000001000000";
        elsif std_match(input, "-00-10-10") then next_state <= s16; output <= "0001101010001000010";
        elsif std_match(input, "-01-10-11") then next_state <= s13; output <= "0001100010001000110";
        elsif std_match(input, "-01-10-10") then next_state <= s13; output <= "0001100010001000010";
        end if;
      when s15 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--11-1-") then next_state <= s17; output <= "0001000001001000001";
        elsif std_match(input, "-0--11-0-") then next_state <= s15; output <= "0001000001001000000";
        elsif std_match(input, "-0--10-1-") then next_state <= s17; output <= "0001000000001000001";
        elsif std_match(input, "-0--10-0-") then next_state <= s15; output <= "0001000000001000000";
        end if;
      when s16 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-00-11-11") then next_state <= s16; output <= "0001101011001000110";
        elsif std_match(input, "-0--11-0-") then next_state <= s16; output <= "0001001001001000000";
        elsif std_match(input, "-00-11-10") then next_state <= s16; output <= "0001101011001000010";
        elsif std_match(input, "-01-11-11") then next_state <= s13; output <= "0001100011001000110";
        elsif std_match(input, "-01-11-10") then next_state <= s13; output <= "0001100011001000010";
        elsif std_match(input, "-00-10-11") then next_state <= s16; output <= "0001101010001000110";
        elsif std_match(input, "-0--10-0-") then next_state <= s16; output <= "0001001000001000000";
        elsif std_match(input, "-00-10-10") then next_state <= s16; output <= "0001101010001000010";
        elsif std_match(input, "-01-10-11") then next_state <= s13; output <= "0001100010001000110";
        elsif std_match(input, "-01-10-10") then next_state <= s13; output <= "0001100010001000010";
        end if;
      when s17 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--11-0-") then next_state <= s17; output <= "0001000001001000001";
        elsif std_match(input, "-0--11-1-") then next_state <= s18; output <= "0001000001001000001";
        elsif std_match(input, "-0--10-0-") then next_state <= s17; output <= "0001000000001000001";
        elsif std_match(input, "-0--10-1-") then next_state <= s18; output <= "0001000000001000001";
        end if;
      when s18 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--11-0-") then next_state <= s18; output <= "0001000001001000001";
        elsif std_match(input, "-0--11-1-") then next_state <= s19; output <= "0011100001000000000";
        elsif std_match(input, "-0--10-0-") then next_state <= s18; output <= "0001000000001000001";
        elsif std_match(input, "-0--10-1-") then next_state <= s19; output <= "0011100000000000000";
        end if;
      when s19 =>
        if std_match(input, "----01---") then next_state <= s1; output <= "0000000001000000000";
        elsif std_match(input, "-1--11---") then next_state <= s5; output <= "0101100101000000000";
        elsif std_match(input, "-1--10---") then next_state <= s5; output <= "0101100100000000000";
        elsif std_match(input, "-0--11-0-") then next_state <= s19; output <= "0001000001000000000";
        elsif std_match(input, "-0--11-1-") then next_state <= s20; output <= "0000000001000000000";
        elsif std_match(input, "-0--10-0-") then next_state <= s19; output <= "0001000000000000000";
        elsif std_match(input, "-0--10-1-") then next_state <= s20; output <= "0000000000000000000";
        end if;
      when s20 =>
        if std_match(input, "-----1---") then next_state <= s1; output <= "0000000001000100000";
        elsif std_match(input, "-----0---") then next_state <= s1; output <= "0000000000000100000";
        end if;
      when others => next_state <= "-----"; output <= "-------------------";
    end case;
  end process;
end behaviour;
