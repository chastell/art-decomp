library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity styr_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(8 downto 0);
    output: out std_logic_vector(9 downto 0)
  );
end styr_rnd;
architecture behaviour of styr_rnd is
  constant st0: std_logic_vector(4 downto 0) := "11101";
  constant st12: std_logic_vector(4 downto 0) := "00010";
  constant st10: std_logic_vector(4 downto 0) := "11011";
  constant st1: std_logic_vector(4 downto 0) := "11110";
  constant st2: std_logic_vector(4 downto 0) := "11111";
  constant st8: std_logic_vector(4 downto 0) := "10001";
  constant st3: std_logic_vector(4 downto 0) := "10110";
  constant st7: std_logic_vector(4 downto 0) := "01011";
  constant st4: std_logic_vector(4 downto 0) := "01111";
  constant st5: std_logic_vector(4 downto 0) := "00001";
  constant st6: std_logic_vector(4 downto 0) := "10000";
  constant st29: std_logic_vector(4 downto 0) := "11010";
  constant st9: std_logic_vector(4 downto 0) := "11000";
  constant st28: std_logic_vector(4 downto 0) := "01000";
  constant st11: std_logic_vector(4 downto 0) := "00100";
  constant st13: std_logic_vector(4 downto 0) := "01001";
  constant st14: std_logic_vector(4 downto 0) := "00110";
  constant st15: std_logic_vector(4 downto 0) := "11100";
  constant st16: std_logic_vector(4 downto 0) := "00011";
  constant st22: std_logic_vector(4 downto 0) := "10111";
  constant st19: std_logic_vector(4 downto 0) := "10011";
  constant st17: std_logic_vector(4 downto 0) := "10010";
  constant st18: std_logic_vector(4 downto 0) := "00111";
  constant st20: std_logic_vector(4 downto 0) := "01100";
  constant st21: std_logic_vector(4 downto 0) := "10101";
  constant st25: std_logic_vector(4 downto 0) := "10100";
  constant st23: std_logic_vector(4 downto 0) := "00000";
  constant st24: std_logic_vector(4 downto 0) := "01101";
  constant st26: std_logic_vector(4 downto 0) := "00101";
  constant st27: std_logic_vector(4 downto 0) := "11001";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "----------";
    case current_state is
      when st0 =>
        if std_match(input, "1-0000---") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-10-----") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "1-1-0----") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "1-0010---") then next_state <= st10; output <= "1000----10";
        elsif std_match(input, "1-0011---") then next_state <= st10; output <= "1000----11";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-010----") then next_state <= st10; output <= "1000----01";
        elsif std_match(input, "1-0001---") then next_state <= st1; output <= "1010100110";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st1 =>
        if std_match(input, "------0--") then next_state <= st2; output <= "0110010000";
        elsif std_match(input, "------1--") then next_state <= st8; output <= "0110100100";
        end if;
      when st2 =>
        if std_match(input, "1-00000--") then next_state <= st2; output <= "010000--00";
        elsif std_match(input, "1-10-----") then next_state <= st2; output <= "010000--00";
        elsif std_match(input, "1-1-0----") then next_state <= st2; output <= "010000--00";
        elsif std_match(input, "1-0010---") then next_state <= st3; output <= "010000--00";
        elsif std_match(input, "1-0011---") then next_state <= st2; output <= "010100--00";
        elsif std_match(input, "11-11----") then next_state <= st0; output <= "0010100000";
        elsif std_match(input, "10-11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-010----") then next_state <= st2; output <= "010000--00";
        elsif std_match(input, "1-0001---") then next_state <= st1; output <= "0110000100";
        elsif std_match(input, "1-00001--") then next_state <= st7; output <= "010000--00";
        elsif std_match(input, "01-------") then next_state <= st0; output <= "0010100000";
        elsif std_match(input, "00-------") then next_state <= st0; output <= "0000------";
        end if;
      when st3 =>
        if std_match(input, "1-0000---") then next_state <= st3; output <= "010000--00";
        elsif std_match(input, "1-10-----") then next_state <= st3; output <= "010000--00";
        elsif std_match(input, "1-1-0----") then next_state <= st3; output <= "010000--00";
        elsif std_match(input, "1-0010---") then next_state <= st4; output <= "0110001000";
        elsif std_match(input, "1-0011---") then next_state <= st3; output <= "010100--00";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-010----") then next_state <= st3; output <= "010000--00";
        elsif std_match(input, "1-0001---") then next_state <= st5; output <= "0110001100";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st4 =>
        if std_match(input, "---------") then next_state <= st6; output <= "0110010000";
        end if;
      when st5 =>
        if std_match(input, "---------") then next_state <= st1; output <= "0110010100";
        end if;
      when st6 =>
        if std_match(input, "1-00000--") then next_state <= st6; output <= "010000--00";
        elsif std_match(input, "1-10-----") then next_state <= st6; output <= "010000--00";
        elsif std_match(input, "1-1-0----") then next_state <= st6; output <= "010000--00";
        elsif std_match(input, "1-0010---") then next_state <= st4; output <= "0110001000";
        elsif std_match(input, "1-0011---") then next_state <= st6; output <= "010100--00";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-010----") then next_state <= st6; output <= "010000--00";
        elsif std_match(input, "1-0001---") then next_state <= st1; output <= "0110000100";
        elsif std_match(input, "1-00001--") then next_state <= st29; output <= "110000--00";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st7 =>
        if std_match(input, "1-0000---") then next_state <= st7; output <= "110000--00";
        elsif std_match(input, "1-10-----") then next_state <= st7; output <= "110000--00";
        elsif std_match(input, "1-1-0----") then next_state <= st7; output <= "110000--00";
        elsif std_match(input, "1-0010---") then next_state <= st29; output <= "110000--00";
        elsif std_match(input, "1-0011---") then next_state <= st7; output <= "110100--00";
        elsif std_match(input, "11-11----") then next_state <= st0; output <= "0010100000";
        elsif std_match(input, "10-11----") then next_state <= st0; output <= "0010------";
        elsif std_match(input, "1-010----") then next_state <= st7; output <= "110000--00";
        elsif std_match(input, "1-0001---") then next_state <= st8; output <= "0110100100";
        elsif std_match(input, "01-------") then next_state <= st0; output <= "0010100000";
        elsif std_match(input, "00-------") then next_state <= st0; output <= "0000------";
        end if;
      when st29 =>
        if std_match(input, "1-0000---") then next_state <= st29; output <= "110000--00";
        elsif std_match(input, "1-10-----") then next_state <= st29; output <= "110000--00";
        elsif std_match(input, "1-1-0----") then next_state <= st29; output <= "110000--00";
        elsif std_match(input, "1-0010---") then next_state <= st29; output <= "110000--00";
        elsif std_match(input, "1-0011---") then next_state <= st29; output <= "110100--00";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-010----") then next_state <= st29; output <= "110000--00";
        elsif std_match(input, "1-0001---") then next_state <= st8; output <= "0110100100";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st8 =>
        if std_match(input, "---------") then next_state <= st9; output <= "0110010000";
        end if;
      when st9 =>
        if std_match(input, "1-00000--") then next_state <= st9; output <= "010000--00";
        elsif std_match(input, "1-10-----") then next_state <= st9; output <= "010000--00";
        elsif std_match(input, "1-1-0----") then next_state <= st9; output <= "010000--00";
        elsif std_match(input, "1-001----") then next_state <= st9; output <= "010000--00";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0010100000";
        elsif std_match(input, "1-010----") then next_state <= st9; output <= "010000--00";
        elsif std_match(input, "1-00001--") then next_state <= st28; output <= "010010--00";
        elsif std_match(input, "1-0001---") then next_state <= st8; output <= "0110000100";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0010100000";
        end if;
      when st28 =>
        if std_match(input, "1-0000---") then next_state <= st28; output <= "110000--00";
        elsif std_match(input, "1-10-----") then next_state <= st28; output <= "110000--00";
        elsif std_match(input, "1-1-0----") then next_state <= st28; output <= "110000--00";
        elsif std_match(input, "1-001----") then next_state <= st28; output <= "110000--00";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0010100000";
        elsif std_match(input, "1-010----") then next_state <= st10; output <= "110000--00";
        elsif std_match(input, "1-0001---") then next_state <= st8; output <= "0110000100";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0010100000";
        end if;
      when st10 =>
        if std_match(input, "1--0---00") then next_state <= st10; output <= "0000----00";
        elsif std_match(input, "1---0--00") then next_state <= st10; output <= "0000----00";
        elsif std_match(input, "1--0---10") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1---0--10") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1--0----1") then next_state <= st11; output <= "0000----00";
        elsif std_match(input, "1---0---1") then next_state <= st11; output <= "0000----00";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st11 =>
        if std_match(input, "1--011-0-") then next_state <= st11; output <= "0000----00";
        elsif std_match(input, "1---0--0-") then next_state <= st11; output <= "0000----00";
        elsif std_match(input, "1--010-0-") then next_state <= st10; output <= "0100----00";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1---0--1-") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1--0---1-") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st12 =>
        if std_match(input, "1--011---") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "1--10----") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "1--000---") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "1-0001---") then next_state <= st10; output <= "1000----01";
        elsif std_match(input, "1--010---") then next_state <= st13; output <= "0000------";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st13 =>
        if std_match(input, "1--000---") then next_state <= st13; output <= "0000------";
        elsif std_match(input, "1--01----") then next_state <= st13; output <= "0000------";
        elsif std_match(input, "1--001---") then next_state <= st14; output <= "0000----01";
        elsif std_match(input, "1--10----") then next_state <= st14; output <= "0000----01";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st14 =>
        if std_match(input, "1--000---") then next_state <= st14; output <= "0000----00";
        elsif std_match(input, "1--01----") then next_state <= st14; output <= "0000----00";
        elsif std_match(input, "1--10----") then next_state <= st14; output <= "0000----00";
        elsif std_match(input, "1--001---") then next_state <= st15; output <= "0010100100";
        elsif std_match(input, "1--11----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st15 =>
        if std_match(input, "--1------") then next_state <= st16; output <= "0010010000";
        elsif std_match(input, "--0------") then next_state <= st22; output <= "0010010000";
        end if;
      when st16 =>
        if std_match(input, "1--000---") then next_state <= st16; output <= "000000--00";
        elsif std_match(input, "1--001---") then next_state <= st19; output <= "0010000100";
        elsif std_match(input, "1--010---") then next_state <= st17; output <= "000000--00";
        elsif std_match(input, "1--011---") then next_state <= st16; output <= "000000--00";
        elsif std_match(input, "1--1-----") then next_state <= st16; output <= "000000--00";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st17 =>
        if std_match(input, "1--000---") then next_state <= st17; output <= "000000--00";
        elsif std_match(input, "1--001---") then next_state <= st18; output <= "0010001100";
        elsif std_match(input, "1--010---") then next_state <= st20; output <= "0010001000";
        elsif std_match(input, "1--011---") then next_state <= st17; output <= "000000--00";
        elsif std_match(input, "1--1-----") then next_state <= st17; output <= "000000--00";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st18 =>
        if std_match(input, "---------") then next_state <= st19; output <= "0010010100";
        end if;
      when st19 =>
        if std_match(input, "---------") then next_state <= st16; output <= "0010010000";
        end if;
      when st20 =>
        if std_match(input, "---------") then next_state <= st21; output <= "0010010000";
        end if;
      when st21 =>
        if std_match(input, "1--000---") then next_state <= st21; output <= "000000--00";
        elsif std_match(input, "1--001---") then next_state <= st19; output <= "0010000100";
        elsif std_match(input, "1--010---") then next_state <= st20; output <= "0010001000";
        elsif std_match(input, "1--011---") then next_state <= st21; output <= "000000--00";
        elsif std_match(input, "1--1-----") then next_state <= st21; output <= "000000--00";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st22 =>
        if std_match(input, "1-0000---") then next_state <= st22; output <= "000000--00";
        elsif std_match(input, "1-0001---") then next_state <= st25; output <= "0010000100";
        elsif std_match(input, "1-0010---") then next_state <= st23; output <= "000000--00";
        elsif std_match(input, "1-0011---") then next_state <= st10; output <= "1000----11";
        elsif std_match(input, "1-010----") then next_state <= st22; output <= "000000--00";
        elsif std_match(input, "1-011----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-1------") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st23 =>
        if std_match(input, "1-0000---") then next_state <= st23; output <= "000000--00";
        elsif std_match(input, "1-0001---") then next_state <= st24; output <= "0010001100";
        elsif std_match(input, "1-0010---") then next_state <= st26; output <= "0010001000";
        elsif std_match(input, "1-0011---") then next_state <= st10; output <= "1000----11";
        elsif std_match(input, "1-010----") then next_state <= st23; output <= "000000--00";
        elsif std_match(input, "1-011----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-1------") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when st24 =>
        if std_match(input, "---------") then next_state <= st25; output <= "0010010100";
        end if;
      when st25 =>
        if std_match(input, "---------") then next_state <= st22; output <= "0010010000";
        end if;
      when st26 =>
        if std_match(input, "---------") then next_state <= st27; output <= "0010010000";
        end if;
      when st27 =>
        if std_match(input, "1-0000---") then next_state <= st27; output <= "000000--00";
        elsif std_match(input, "1-0001---") then next_state <= st25; output <= "0010000100";
        elsif std_match(input, "1-0010---") then next_state <= st26; output <= "0010001000";
        elsif std_match(input, "1-0011---") then next_state <= st10; output <= "1000----11";
        elsif std_match(input, "1-010----") then next_state <= st27; output <= "000000--00";
        elsif std_match(input, "1-011----") then next_state <= st0; output <= "0000------";
        elsif std_match(input, "1-1------") then next_state <= st12; output <= "0000------";
        elsif std_match(input, "0--------") then next_state <= st0; output <= "0000------";
        end if;
      when others => next_state <= "-----"; output <= "----------";
    end case;
  end process;
end behaviour;
