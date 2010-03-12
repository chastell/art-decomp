library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity sand_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(10 downto 0);
    output: out std_logic_vector(8 downto 0)
  );
end sand_jed;
architecture behaviour of sand_jed is
  constant st0: std_logic_vector(4 downto 0) := "00101";
  constant st5: std_logic_vector(4 downto 0) := "00010";
  constant st1: std_logic_vector(4 downto 0) := "00001";
  constant st2: std_logic_vector(4 downto 0) := "00011";
  constant st4: std_logic_vector(4 downto 0) := "01001";
  constant st3: std_logic_vector(4 downto 0) := "10001";
  constant st31: std_logic_vector(4 downto 0) := "00110";
  constant st25: std_logic_vector(4 downto 0) := "10011";
  constant st19: std_logic_vector(4 downto 0) := "01011";
  constant st6: std_logic_vector(4 downto 0) := "10010";
  constant st29: std_logic_vector(4 downto 0) := "00111";
  constant st23: std_logic_vector(4 downto 0) := "10110";
  constant st17: std_logic_vector(4 downto 0) := "11010";
  constant st13: std_logic_vector(4 downto 0) := "11000";
  constant st27: std_logic_vector(4 downto 0) := "01010";
  constant st21: std_logic_vector(4 downto 0) := "01100";
  constant st15: std_logic_vector(4 downto 0) := "01110";
  constant st12: std_logic_vector(4 downto 0) := "10000";
  constant st10: std_logic_vector(4 downto 0) := "10100";
  constant st7: std_logic_vector(4 downto 0) := "00100";
  constant st8: std_logic_vector(4 downto 0) := "00000";
  constant st9: std_logic_vector(4 downto 0) := "01000";
  constant st11: std_logic_vector(4 downto 0) := "10101";
  constant st14: std_logic_vector(4 downto 0) := "11100";
  constant st16: std_logic_vector(4 downto 0) := "11110";
  constant st18: std_logic_vector(4 downto 0) := "11011";
  constant st20: std_logic_vector(4 downto 0) := "01101";
  constant st22: std_logic_vector(4 downto 0) := "11101";
  constant st24: std_logic_vector(4 downto 0) := "10111";
  constant st26: std_logic_vector(4 downto 0) := "11001";
  constant st28: std_logic_vector(4 downto 0) := "01111";
  constant st30: std_logic_vector(4 downto 0) := "11111";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "---------";
    case current_state is
      when st0 =>
        if std_match(input, "---------0-") then next_state <= st0; output <= "000001---";
        elsif std_match(input, "----0----1-") then next_state <= st0; output <= "000001---";
        elsif std_match(input, "----1---11-") then next_state <= st5; output <= "011001000";
        elsif std_match(input, "----1---01-") then next_state <= st1; output <= "11-001000";
        end if;
      when st1 =>
        if std_match(input, "0000---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0000---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "0001---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0001---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "0010---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0010---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "0011---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0011---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "0100---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0100---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "0101---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0101---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "0110---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0110---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "0111---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "0111---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "1000---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "1000---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "1001---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "1001---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "1010---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "1010---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "1011---0-0-") then next_state <= st1; output <= "0001-0000";
        elsif std_match(input, "1011---0-1-") then next_state <= st2; output <= "11-1-0100";
        elsif std_match(input, "1100---0---") then next_state <= st4; output <= "1010-0100";
        elsif std_match(input, "1101---0---") then next_state <= st3; output <= "0000-0110";
        elsif std_match(input, "1111--10---") then next_state <= st0; output <= "11-0---01";
        elsif std_match(input, "1111--00---") then next_state <= st1; output <= "11-0-0000";
        elsif std_match(input, "-------1---") then next_state <= st0; output <= "11-0-----";
        end if;
      when st2 =>
        if std_match(input, "-------0-0-") then next_state <= st2; output <= "0000-0000";
        elsif std_match(input, "-------0-10") then next_state <= st1; output <= "11-0-0000";
        elsif std_match(input, "----0-00-11") then next_state <= st1; output <= "11-0-1000";
        elsif std_match(input, "----1-00-11") then next_state <= st2; output <= "0000-0000";
        elsif std_match(input, "------10-11") then next_state <= st0; output <= "11-0---01";
        elsif std_match(input, "-------1---") then next_state <= st0; output <= "11-0-----";
        end if;
      when st3 =>
        if std_match(input, "------10--1") then next_state <= st0; output <= "11-0---01";
        elsif std_match(input, "-----010--0") then next_state <= st3; output <= "---0-0000";
        elsif std_match(input, "-----110--0") then next_state <= st1; output <= "11-0-0000";
        elsif std_match(input, "----1-00--1") then next_state <= st3; output <= "---0-0000";
        elsif std_match(input, "----0-00--1") then next_state <= st1; output <= "11-0-1000";
        elsif std_match(input, "------00--0") then next_state <= st1; output <= "11-0-0000";
        elsif std_match(input, "-------1---") then next_state <= st0; output <= "11-0-----";
        end if;
      when st4 =>
        if std_match(input, "------10-00") then next_state <= st4; output <= "0000-0000";
        elsif std_match(input, "------10-01") then next_state <= st0; output <= "11-0---01";
        elsif std_match(input, "------00-00") then next_state <= st1; output <= "11-0-0000";
        elsif std_match(input, "----1-00--1") then next_state <= st4; output <= "---0-0000";
        elsif std_match(input, "----0-00--1") then next_state <= st3; output <= "11-0-0000";
        elsif std_match(input, "------10-1-") then next_state <= st1; output <= "11-0-0000";
        elsif std_match(input, "-------1---") then next_state <= st0; output <= "11-0---00";
        end if;
      when st5 =>
        if std_match(input, "0000-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "0000-----1-") then next_state <= st31; output <= "010110100";
        elsif std_match(input, "0001-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "0001-----1-") then next_state <= st25; output <= "010110100";
        elsif std_match(input, "0010-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "0010-----1-") then next_state <= st19; output <= "010110100";
        elsif std_match(input, "0011-------") then next_state <= st6; output <= "000100100";
        elsif std_match(input, "0100-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "0100-----1-") then next_state <= st29; output <= "010110100";
        elsif std_match(input, "0101-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "0101-----1-") then next_state <= st23; output <= "010110100";
        elsif std_match(input, "0110-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "0110-----1-") then next_state <= st17; output <= "010110100";
        elsif std_match(input, "0111-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "0111-----1-") then next_state <= st13; output <= "010110100";
        elsif std_match(input, "1000-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "1000-----1-") then next_state <= st27; output <= "010110100";
        elsif std_match(input, "1001-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "1001-----1-") then next_state <= st21; output <= "010110100";
        elsif std_match(input, "1010-----0-") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "1010-----1-") then next_state <= st15; output <= "010110100";
        elsif std_match(input, "1011-------") then next_state <= st6; output <= "000100100";
        elsif std_match(input, "1100-------") then next_state <= st12; output <= "101100100";
        elsif std_match(input, "1101-------") then next_state <= st10; output <= "011100110";
        elsif std_match(input, "1111-------") then next_state <= st7; output <= "011100000";
        end if;
      when st6 =>
        if std_match(input, "----------0") then next_state <= st5; output <= "000100000";
        elsif std_match(input, "----0-0---1") then next_state <= st5; output <= "000101000";
        elsif std_match(input, "----1-0---1") then next_state <= st7; output <= "011101000";
        end if;
      when st7 =>
        if std_match(input, "-----1---1-") then next_state <= st8; output <= "100000000";
        elsif std_match(input, "-----0---1-") then next_state <= st0; output <= "10000--01";
        elsif std_match(input, "---------0-") then next_state <= st7; output <= "000100000";
        end if;
      when st8 =>
        if std_match(input, "0000-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "00000----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "00001----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "0001-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "00010----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "00011----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "0010-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "00100----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "00101----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "0011-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "00110----1-") then next_state <= st9; output <= "---000100";
        elsif std_match(input, "00111----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "0100-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "01000----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "01001----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "0101-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "01010----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "01011----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "0110-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "01100----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "01101----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "0111-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "01110----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "01111----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "1000-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "10000----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "10001----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "1001-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "10010----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "10011----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "1010-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "10100----1-") then next_state <= st5; output <= "011100000";
        elsif std_match(input, "10101----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "1011-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "10110----1-") then next_state <= st9; output <= "---000100";
        elsif std_match(input, "10111----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "1100-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "11000----1-") then next_state <= st9; output <= "---000100";
        elsif std_match(input, "11001----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "1101-----0-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "11010----1-") then next_state <= st9; output <= "---000100";
        elsif std_match(input, "11011----1-") then next_state <= st8; output <= "000000000";
        elsif std_match(input, "1111-------") then next_state <= st8; output <= "000000000";
        end if;
      when st9 =>
        if std_match(input, "----------1") then next_state <= st8; output <= "001001000";
        elsif std_match(input, "----------0") then next_state <= st8; output <= "000000000";
        end if;
      when st10 =>
        if std_match(input, "------1--10") then next_state <= st11; output <= "---000010";
        elsif std_match(input, "------1--00") then next_state <= st10; output <= "000100000";
        elsif std_match(input, "------1---1") then next_state <= st0; output <= "10000--01";
        elsif std_match(input, "------0---0") then next_state <= st5; output <= "100100000";
        elsif std_match(input, "----0-0---1") then next_state <= st5; output <= "100101000";
        elsif std_match(input, "----1-0---1") then next_state <= st10; output <= "---101000";
        end if;
      when st11 =>
        if std_match(input, "-----0-----") then next_state <= st11; output <= "---000000";
        elsif std_match(input, "-----1-----") then next_state <= st5; output <= "011100000";
        end if;
      when st12 =>
        if std_match(input, "------1--10") then next_state <= st5; output <= "001100000";
        elsif std_match(input, "------1--00") then next_state <= st12; output <= "000100000";
        elsif std_match(input, "------1---1") then next_state <= st7; output <= "01110--00";
        elsif std_match(input, "------0---0") then next_state <= st5; output <= "100100000";
        elsif std_match(input, "----0-0---1") then next_state <= st5; output <= "100101000";
        elsif std_match(input, "----1-0---1") then next_state <= st12; output <= "---101000";
        end if;
      when st13 =>
        if std_match(input, "---------0-") then next_state <= st13; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st14; output <= "001100000";
        end if;
      when st14 =>
        if std_match(input, "---------0-") then next_state <= st14; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st15; output <= "010110000";
        end if;
      when st15 =>
        if std_match(input, "---------0-") then next_state <= st15; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st16; output <= "001100000";
        end if;
      when st16 =>
        if std_match(input, "---------0-") then next_state <= st16; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st17; output <= "010110000";
        end if;
      when st17 =>
        if std_match(input, "---------0-") then next_state <= st17; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st18; output <= "001100000";
        end if;
      when st18 =>
        if std_match(input, "---------0-") then next_state <= st18; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st19; output <= "010110000";
        end if;
      when st19 =>
        if std_match(input, "---------0-") then next_state <= st19; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st20; output <= "001100000";
        end if;
      when st20 =>
        if std_match(input, "---------0-") then next_state <= st20; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st21; output <= "010110000";
        end if;
      when st21 =>
        if std_match(input, "---------0-") then next_state <= st21; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st22; output <= "001100000";
        end if;
      when st22 =>
        if std_match(input, "---------0-") then next_state <= st22; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st23; output <= "010110000";
        end if;
      when st23 =>
        if std_match(input, "---------0-") then next_state <= st23; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st24; output <= "001100000";
        end if;
      when st24 =>
        if std_match(input, "---------0-") then next_state <= st24; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st25; output <= "010110000";
        end if;
      when st25 =>
        if std_match(input, "---------0-") then next_state <= st25; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st26; output <= "001100000";
        end if;
      when st26 =>
        if std_match(input, "---------0-") then next_state <= st26; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st27; output <= "010110000";
        end if;
      when st27 =>
        if std_match(input, "---------0-") then next_state <= st27; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st28; output <= "001100000";
        end if;
      when st28 =>
        if std_match(input, "---------0-") then next_state <= st28; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st29; output <= "010110000";
        end if;
      when st29 =>
        if std_match(input, "---------0-") then next_state <= st29; output <= "000110000";
        elsif std_match(input, "---------1-") then next_state <= st30; output <= "001100000";
        end if;
      when st30 =>
        if std_match(input, "---------0-") then next_state <= st30; output <= "000100000";
        elsif std_match(input, "---------1-") then next_state <= st31; output <= "010110000";
        end if;
      when st31 =>
        if std_match(input, "---------0-") then next_state <= st31; output <= "000110000";
        elsif std_match(input, "---------10") then next_state <= st5; output <= "100100000";
        elsif std_match(input, "------1--11") then next_state <= st7; output <= "01110--00";
        elsif std_match(input, "----0-0--11") then next_state <= st5; output <= "100101000";
        elsif std_match(input, "----1-0--11") then next_state <= st7; output <= "011101000";
        end if;
      when others => next_state <= "-----"; output <= "---------";
    end case;
  end process;
end behaviour;
