library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity planet_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(6 downto 0);
    output: out std_logic_vector(18 downto 0)
  );
end planet_rnd;
architecture behaviour of planet_rnd is
  constant st0: std_logic_vector(5 downto 0) := "111101";
  constant st1: std_logic_vector(5 downto 0) := "000010";
  constant st2: std_logic_vector(5 downto 0) := "011011";
  constant st3: std_logic_vector(5 downto 0) := "111110";
  constant st4: std_logic_vector(5 downto 0) := "111111";
  constant st42: std_logic_vector(5 downto 0) := "010001";
  constant st5: std_logic_vector(5 downto 0) := "010110";
  constant st6: std_logic_vector(5 downto 0) := "001011";
  constant st7: std_logic_vector(5 downto 0) := "001111";
  constant st41: std_logic_vector(5 downto 0) := "011110";
  constant st38: std_logic_vector(5 downto 0) := "101011";
  constant st8: std_logic_vector(5 downto 0) := "100001";
  constant st10: std_logic_vector(5 downto 0) := "110000";
  constant st9: std_logic_vector(5 downto 0) := "101111";
  constant st11: std_logic_vector(5 downto 0) := "011010";
  constant st12: std_logic_vector(5 downto 0) := "111000";
  constant st13: std_logic_vector(5 downto 0) := "110110";
  constant st14: std_logic_vector(5 downto 0) := "001000";
  constant st15: std_logic_vector(5 downto 0) := "000001";
  constant st16: std_logic_vector(5 downto 0) := "100100";
  constant st17: std_logic_vector(5 downto 0) := "001001";
  constant st18: std_logic_vector(5 downto 0) := "101001";
  constant st19: std_logic_vector(5 downto 0) := "100110";
  constant st46: std_logic_vector(5 downto 0) := "111011";
  constant st24: std_logic_vector(5 downto 0) := "011100";
  constant st20: std_logic_vector(5 downto 0) := "100011";
  constant st25: std_logic_vector(5 downto 0) := "100010";
  constant st21: std_logic_vector(5 downto 0) := "011000";
  constant st22: std_logic_vector(5 downto 0) := "000011";
  constant st23: std_logic_vector(5 downto 0) := "110111";
  constant st26: std_logic_vector(5 downto 0) := "010011";
  constant st28: std_logic_vector(5 downto 0) := "110010";
  constant st30: std_logic_vector(5 downto 0) := "000111";
  constant st27: std_logic_vector(5 downto 0) := "001100";
  constant st29: std_logic_vector(5 downto 0) := "110101";
  constant st31: std_logic_vector(5 downto 0) := "010100";
  constant st32: std_logic_vector(5 downto 0) := "000000";
  constant st33: std_logic_vector(5 downto 0) := "100111";
  constant st35: std_logic_vector(5 downto 0) := "011101";
  constant st34: std_logic_vector(5 downto 0) := "101101";
  constant st36: std_logic_vector(5 downto 0) := "100101";
  constant st37: std_logic_vector(5 downto 0) := "100000";
  constant st39: std_logic_vector(5 downto 0) := "111100";
  constant st40: std_logic_vector(5 downto 0) := "000100";
  constant st43: std_logic_vector(5 downto 0) := "110011";
  constant st44: std_logic_vector(5 downto 0) := "010111";
  constant st45: std_logic_vector(5 downto 0) := "111010";
  constant st47: std_logic_vector(5 downto 0) := "111001";
  signal current_state, next_state: std_logic_vector(5 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "------"; output <= "-------------------";
    case current_state is
      when st0 =>
        if std_match(input, "-------") then next_state <= st1; output <= "001011101000000---0";
        end if;
      when st1 =>
        if std_match(input, "----01-") then next_state <= st1; output <= "--------0000000---0";
        elsif std_match(input, "----10-") then next_state <= st1; output <= "--------0100000---1";
        elsif std_match(input, "----00-") then next_state <= st1; output <= "1000----1000000---1";
        elsif std_match(input, "----11-") then next_state <= st2; output <= "1000111110011001000";
        end if;
      when st2 =>
        if std_match(input, "------0") then next_state <= st3; output <= "1010010010000000000";
        elsif std_match(input, "---0---") then next_state <= st3; output <= "1010010010000000000";
        elsif std_match(input, "---1--1") then next_state <= st0; output <= "1010----1010010---1";
        end if;
      when st3 =>
        if std_match(input, "11-----") then next_state <= st4; output <= "001111101000000-010";
        elsif std_match(input, "10-----") then next_state <= st4; output <= "0011111110000000-10";
        elsif std_match(input, "0-0-01-") then next_state <= st4; output <= "--------000010000-0";
        elsif std_match(input, "0-0-10-") then next_state <= st4; output <= "--------010010000-1";
        elsif std_match(input, "0-0-11-") then next_state <= st42; output <= "011011011000100---0";
        elsif std_match(input, "0-0-00-") then next_state <= st4; output <= "0110----100000000-1";
        elsif std_match(input, "0-1-01-") then next_state <= st4; output <= "--------00011000000";
        elsif std_match(input, "0-1-10-") then next_state <= st4; output <= "--------01011000001";
        elsif std_match(input, "0-1-11-") then next_state <= st42; output <= "011011011001100--00";
        elsif std_match(input, "0-1-00-") then next_state <= st4; output <= "0110----10010000001";
        end if;
      when st4 =>
        if std_match(input, "-------") then next_state <= st5; output <= "1010010010000000000";
        end if;
      when st5 =>
        if std_match(input, "--0----") then next_state <= st6; output <= "1000011110000000001";
        elsif std_match(input, "--1----") then next_state <= st6; output <= "1000011110010000001";
        end if;
      when st6 =>
        if std_match(input, "-1----0") then next_state <= st7; output <= "101001001000000-000";
        elsif std_match(input, "-110--1") then next_state <= st7; output <= "101001001000000-000";
        elsif std_match(input, "-10---1") then next_state <= st41; output <= "101001001000000--00";
        elsif std_match(input, "-111--1") then next_state <= st38; output <= "101001001000000--00";
        elsif std_match(input, "-0-----") then next_state <= st7; output <= "1010010010000000-00";
        end if;
      when st7 =>
        if std_match(input, "--1----") then next_state <= st8; output <= "0001101010010000000";
        elsif std_match(input, "--0----") then next_state <= st8; output <= "0001101010000000000";
        end if;
      when st8 =>
        if std_match(input, "--0----") then next_state <= st10; output <= "1010010010000000000";
        elsif std_match(input, "--1----") then next_state <= st9; output <= "1010010010000000000";
        end if;
      when st9 =>
        if std_match(input, "-11----") then next_state <= st11; output <= "001011101001000-000";
        elsif std_match(input, "-01----") then next_state <= st11; output <= "0010111110010000-00";
        elsif std_match(input, "-10----") then next_state <= st11; output <= "001011101000000-000";
        elsif std_match(input, "-00----") then next_state <= st11; output <= "0010111110000000-00";
        end if;
      when st10 =>
        if std_match(input, "--1----") then next_state <= st12; output <= "0010----10010000001";
        elsif std_match(input, "--0----") then next_state <= st12; output <= "0010----10000000001";
        end if;
      when st11 =>
        if std_match(input, "-------") then next_state <= st13; output <= "1010010010000000000";
        end if;
      when st12 =>
        if std_match(input, "-------") then next_state <= st14; output <= "1010010010000000000";
        end if;
      when st13 =>
        if std_match(input, "-11----") then next_state <= st15; output <= "010110011001000-000";
        elsif std_match(input, "-10----") then next_state <= st15; output <= "010110011000000-000";
        elsif std_match(input, "-01----") then next_state <= st15; output <= "0101100010010000-00";
        elsif std_match(input, "-00----") then next_state <= st15; output <= "0101100010000000-00";
        end if;
      when st14 =>
        if std_match(input, "--1----") then next_state <= st15; output <= "0101----10010000001";
        elsif std_match(input, "--0----") then next_state <= st15; output <= "0101----10000000001";
        end if;
      when st15 =>
        if std_match(input, "-------") then next_state <= st16; output <= "1010010010000000000";
        end if;
      when st16 =>
        if std_match(input, "--1----") then next_state <= st17; output <= "0110010110010000001";
        elsif std_match(input, "--0----") then next_state <= st17; output <= "0110010110000000001";
        end if;
      when st17 =>
        if std_match(input, "---0---") then next_state <= st18; output <= "1010010010000000000";
        elsif std_match(input, "01-1---") then next_state <= st19; output <= "101001001000001-0-0";
        elsif std_match(input, "00-1--0") then next_state <= st19; output <= "1010010010000010--0";
        elsif std_match(input, "00-1--1") then next_state <= st46; output <= "101001001000000---0";
        elsif std_match(input, "11-1---") then next_state <= st24; output <= "101001001000001-000";
        elsif std_match(input, "10-1--0") then next_state <= st24; output <= "1010010010000010-00";
        elsif std_match(input, "10-1--1") then next_state <= st18; output <= "1010010010000000-00";
        end if;
      when st18 =>
        if std_match(input, "--1----") then next_state <= st2; output <= "1000111110010000000";
        elsif std_match(input, "0-0----") then next_state <= st2; output <= "1000----10000000001";
        elsif std_match(input, "1-0----") then next_state <= st2; output <= "1000111110000000000";
        end if;
      when st19 =>
        if std_match(input, "-10----") then next_state <= st20; output <= "100101001000000-0-0";
        elsif std_match(input, "-00----") then next_state <= st20; output <= "1001010110000000--0";
        elsif std_match(input, "--1----") then next_state <= st25; output <= "100011111001000--00";
        end if;
      when st20 =>
        if std_match(input, "-10----") then next_state <= st19; output <= "101001001000000-0-0";
        elsif std_match(input, "-11----") then next_state <= st21; output <= "101001001000000-0-0";
        elsif std_match(input, "-01----") then next_state <= st19; output <= "1010010010000000--0";
        elsif std_match(input, "-00----") then next_state <= st21; output <= "1010010010000000--0";
        end if;
      when st21 =>
        if std_match(input, "-10----") then next_state <= st22; output <= "001111111000000-0-0";
        elsif std_match(input, "-11----") then next_state <= st23; output <= "001111111001000--00";
        elsif std_match(input, "-00----") then next_state <= st22; output <= "0011111010000000--0";
        elsif std_match(input, "-01----") then next_state <= st23; output <= "001111101001000--00";
        end if;
      when st22 =>
        if std_match(input, "-------") then next_state <= st19; output <= "10100100100000000-0";
        end if;
      when st23 =>
        if std_match(input, "-------") then next_state <= st24; output <= "101001001000000--00";
        end if;
      when st24 =>
        if std_match(input, "-------") then next_state <= st25; output <= "100011111000000--00";
        end if;
      when st25 =>
        if std_match(input, "---0--0") then next_state <= st26; output <= "101001001000000---0";
        elsif std_match(input, "---1--0") then next_state <= st28; output <= "101001001000010--00";
        elsif std_match(input, "------1") then next_state <= st30; output <= "101001001000000--10";
        end if;
      when st26 =>
        if std_match(input, "--0-01-") then next_state <= st27; output <= "--------0000100---0";
        elsif std_match(input, "--0-10-") then next_state <= st27; output <= "--------0100100---1";
        elsif std_match(input, "--0-00-") then next_state <= st27; output <= "0110----1000000---1";
        elsif std_match(input, "--0-11-") then next_state <= st42; output <= "011011011000100---0";
        elsif std_match(input, "--1----") then next_state <= st25; output <= "100011111001000--00";
        end if;
      when st27 =>
        if std_match(input, "-------") then next_state <= st26; output <= "101001001000000---0";
        end if;
      when st28 =>
        if std_match(input, "-------") then next_state <= st29; output <= "011001011000000--01";
        end if;
      when st29 =>
        if std_match(input, "---1---") then next_state <= st26; output <= "101001001000000---0";
        elsif std_match(input, "--10---") then next_state <= st3; output <= "1010010010000001000";
        elsif std_match(input, "--00---") then next_state <= st3; output <= "1010010010000000100";
        end if;
      when st30 =>
        if std_match(input, "-------") then next_state <= st31; output <= "100001111000000---1";
        end if;
      when st31 =>
        if std_match(input, "---0---") then next_state <= st26; output <= "101001001000000---0";
        elsif std_match(input, "---1---") then next_state <= st32; output <= "101001001000000---0";
        end if;
      when st32 =>
        if std_match(input, "--0----") then next_state <= st33; output <= "100101011000000---0";
        elsif std_match(input, "--1----") then next_state <= st35; output <= "011011011001000--00";
        end if;
      when st33 =>
        if std_match(input, "--10---") then next_state <= st32; output <= "101001001000000---0";
        elsif std_match(input, "--0----") then next_state <= st34; output <= "101001001000000---0";
        elsif std_match(input, "---1---") then next_state <= st34; output <= "101001001000000---0";
        end if;
      when st34 =>
        if std_match(input, "--1----") then next_state <= st35; output <= "011011011001000--00";
        elsif std_match(input, "--0----") then next_state <= st35; output <= "011011011000000---0";
        end if;
      when st35 =>
        if std_match(input, "-------") then next_state <= st36; output <= "101001001000000--00";
        end if;
      when st36 =>
        if std_match(input, "--0----") then next_state <= st37; output <= "011011101000000--00";
        elsif std_match(input, "--1----") then next_state <= st37; output <= "011011101001000--00";
        end if;
      when st37 =>
        if std_match(input, "-------") then next_state <= st9; output <= "1010010010000000100";
        end if;
      when st38 =>
        if std_match(input, "--0-01-") then next_state <= st39; output <= "--------0000100---0";
        elsif std_match(input, "--0-10-") then next_state <= st39; output <= "--------0100100---1";
        elsif std_match(input, "--0-11-") then next_state <= st42; output <= "011011011000100---0";
        elsif std_match(input, "--0-00-") then next_state <= st39; output <= "0110----1000000---1";
        elsif std_match(input, "--1----") then next_state <= st40; output <= "100011111001000--00";
        end if;
      when st39 =>
        if std_match(input, "-------") then next_state <= st38; output <= "101001001000000---0";
        end if;
      when st40 =>
        if std_match(input, "-------") then next_state <= st41; output <= "101001001000000--10";
        end if;
      when st41 =>
        if std_match(input, "-------") then next_state <= st42; output <= "011011011000000---0";
        end if;
      when st42 =>
        if std_match(input, "-------") then next_state <= st43; output <= "101001001000000--00";
        end if;
      when st43 =>
        if std_match(input, "--0----") then next_state <= st44; output <= "011011101000000--00";
        elsif std_match(input, "--1----") then next_state <= st44; output <= "011011101001000--00";
        end if;
      when st44 =>
        if std_match(input, "-------") then next_state <= st45; output <= "101001001000000--00";
        end if;
      when st45 =>
        if std_match(input, "--0----") then next_state <= st6; output <= "0111001110000000100";
        elsif std_match(input, "--1----") then next_state <= st6; output <= "0111001110010000100";
        end if;
      when st46 =>
        if std_match(input, "--0----") then next_state <= st47; output <= "1000----1000000---1";
        elsif std_match(input, "--1----") then next_state <= st0; output <= "100011111011010---0";
        end if;
      when st47 =>
        if std_match(input, "-------") then next_state <= st46; output <= "101001001000000---0";
        end if;
      when others => next_state <= "------"; output <= "-------------------";
    end case;
  end process;
end behaviour;
