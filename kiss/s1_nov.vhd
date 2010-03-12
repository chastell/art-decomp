library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s1_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(7 downto 0);
    output: out std_logic_vector(5 downto 0)
  );
end s1_nov;
architecture behaviour of s1_nov is
  constant st0: std_logic_vector(4 downto 0) := "10110";
  constant st1: std_logic_vector(4 downto 0) := "11010";
  constant st2: std_logic_vector(4 downto 0) := "10101";
  constant st3: std_logic_vector(4 downto 0) := "01010";
  constant st4: std_logic_vector(4 downto 0) := "11001";
  constant st5: std_logic_vector(4 downto 0) := "00110";
  constant st6: std_logic_vector(4 downto 0) := "00011";
  constant st7: std_logic_vector(4 downto 0) := "01110";
  constant st8: std_logic_vector(4 downto 0) := "00000";
  constant st9: std_logic_vector(4 downto 0) := "11111";
  constant st10: std_logic_vector(4 downto 0) := "00100";
  constant st11: std_logic_vector(4 downto 0) := "01001";
  constant st12: std_logic_vector(4 downto 0) := "00001";
  constant st13: std_logic_vector(4 downto 0) := "10001";
  constant st14: std_logic_vector(4 downto 0) := "10010";
  constant st15: std_logic_vector(4 downto 0) := "11100";
  constant st16: std_logic_vector(4 downto 0) := "11110";
  constant st17: std_logic_vector(4 downto 0) := "01101";
  constant st18: std_logic_vector(4 downto 0) := "00010";
  constant st19: std_logic_vector(4 downto 0) := "11101";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "------";
    case current_state is
      when st0 =>
        if std_match(input, "-1-00---") then next_state <= st0; output <= "000001";
        elsif std_match(input, "00--0---") then next_state <= st0; output <= "000001";
        elsif std_match(input, "-0--1---") then next_state <= st1; output <= "000011";
        elsif std_match(input, "-1-01---") then next_state <= st1; output <= "000011";
        elsif std_match(input, "01-10---") then next_state <= st2; output <= "001001";
        elsif std_match(input, "11-10---") then next_state <= st5; output <= "011001";
        elsif std_match(input, "-1-11---") then next_state <= st3; output <= "001011";
        elsif std_match(input, "10--0---") then next_state <= st4; output <= "010001";
        end if;
      when st1 =>
        if std_match(input, "-0------") then next_state <= st6; output <= "000101";
        elsif std_match(input, "-1-0----") then next_state <= st6; output <= "000101";
        elsif std_match(input, "-1-1----") then next_state <= st7; output <= "001101";
        end if;
      when st2 =>
        if std_match(input, "0---0---") then next_state <= st2; output <= "001001";
        elsif std_match(input, "----1---") then next_state <= st3; output <= "001011";
        elsif std_match(input, "1---0---") then next_state <= st5; output <= "011001";
        end if;
      when st3 =>
        if std_match(input, "--------") then next_state <= st7; output <= "001101";
        end if;
      when st4 =>
        if std_match(input, "--0-----") then next_state <= st12; output <= "100001";
        elsif std_match(input, "--1-----") then next_state <= st13; output <= "101001";
        end if;
      when st5 =>
        if std_match(input, "--------") then next_state <= st13; output <= "101001";
        end if;
      when st6 =>
        if std_match(input, "-0--1---") then next_state <= st6; output <= "000101";
        elsif std_match(input, "-1-01---") then next_state <= st6; output <= "000101";
        elsif std_match(input, "-1-11---") then next_state <= st7; output <= "001101";
        elsif std_match(input, "00--0---") then next_state <= st8; output <= "000000";
        elsif std_match(input, "-1-00---") then next_state <= st8; output <= "000000";
        elsif std_match(input, "11-10---") then next_state <= st11; output <= "011000";
        elsif std_match(input, "10--0---") then next_state <= st15; output <= "010000";
        elsif std_match(input, "01-10---") then next_state <= st9; output <= "001000";
        end if;
      when st7 =>
        if std_match(input, "----1---") then next_state <= st7; output <= "001101";
        elsif std_match(input, "0---0---") then next_state <= st9; output <= "001000";
        elsif std_match(input, "1---0---") then next_state <= st11; output <= "011000";
        end if;
      when st8 =>
        if std_match(input, "00--00--") then next_state <= st8; output <= "000000";
        elsif std_match(input, "00---1-0") then next_state <= st8; output <= "000000";
        elsif std_match(input, "-1-000--") then next_state <= st8; output <= "000000";
        elsif std_match(input, "-1-0-1-0") then next_state <= st8; output <= "000000";
        elsif std_match(input, "00--01-1") then next_state <= st0; output <= "000001";
        elsif std_match(input, "-1-001-1") then next_state <= st0; output <= "000001";
        elsif std_match(input, "-0--11-1") then next_state <= st1; output <= "000011";
        elsif std_match(input, "-1-011-1") then next_state <= st1; output <= "000011";
        elsif std_match(input, "10--01-1") then next_state <= st4; output <= "010001";
        elsif std_match(input, "01-100--") then next_state <= st9; output <= "001000";
        elsif std_match(input, "01-1-1--") then next_state <= st9; output <= "001000";
        elsif std_match(input, "01-110--") then next_state <= st10; output <= "001010";
        elsif std_match(input, "11-1----") then next_state <= st11; output <= "011000";
        elsif std_match(input, "100-10--") then next_state <= st14; output <= "000010";
        elsif std_match(input, "-1-010--") then next_state <= st14; output <= "000010";
        elsif std_match(input, "101-101-") then next_state <= st14; output <= "000010";
        elsif std_match(input, "00--10--") then next_state <= st14; output <= "000010";
        elsif std_match(input, "10--00--") then next_state <= st15; output <= "010000";
        elsif std_match(input, "10---1-0") then next_state <= st15; output <= "010000";
        elsif std_match(input, "101-100-") then next_state <= st15; output <= "010000";
        end if;
      when st9 =>
        if std_match(input, "0---00--") then next_state <= st9; output <= "001000";
        elsif std_match(input, "0----1-0") then next_state <= st9; output <= "001000";
        elsif std_match(input, "0---01-1") then next_state <= st2; output <= "001001";
        elsif std_match(input, "0---10--") then next_state <= st10; output <= "001010";
        elsif std_match(input, "0---11-1") then next_state <= st3; output <= "001011";
        elsif std_match(input, "1----0--") then next_state <= st11; output <= "011000";
        elsif std_match(input, "1----1-0") then next_state <= st11; output <= "011000";
        elsif std_match(input, "1----1-1") then next_state <= st5; output <= "011001";
        end if;
      when st10 =>
        if std_match(input, "------0-") then next_state <= st16; output <= "001100";
        elsif std_match(input, "------1-") then next_state <= st7; output <= "001101";
        end if;
      when st11 =>
        if std_match(input, "-----1-1") then next_state <= st13; output <= "101001";
        elsif std_match(input, "-----0--") then next_state <= st17; output <= "101000";
        elsif std_match(input, "-----1-0") then next_state <= st17; output <= "101000";
        end if;
      when st12 =>
        if std_match(input, "1-0-----") then next_state <= st12; output <= "100001";
        elsif std_match(input, "1-1-----") then next_state <= st13; output <= "101001";
        elsif std_match(input, "0---1---") then next_state <= st1; output <= "000011";
        elsif std_match(input, "0---0---") then next_state <= st0; output <= "000001";
        end if;
      when st13 =>
        if std_match(input, "1-------") then next_state <= st13; output <= "101001";
        elsif std_match(input, "0---0---") then next_state <= st0; output <= "000001";
        elsif std_match(input, "0---1---") then next_state <= st1; output <= "000011";
        end if;
      when st14 =>
        if std_match(input, "---0--1-") then next_state <= st6; output <= "000101";
        elsif std_match(input, "---0--0-") then next_state <= st18; output <= "000100";
        elsif std_match(input, "-0-1----") then next_state <= st18; output <= "000100";
        elsif std_match(input, "-1-1----") then next_state <= st16; output <= "001100";
        end if;
      when st15 =>
        if std_match(input, "--0--0--") then next_state <= st19; output <= "100000";
        elsif std_match(input, "--0--1-0") then next_state <= st19; output <= "100000";
        elsif std_match(input, "--0--1-1") then next_state <= st12; output <= "100001";
        elsif std_match(input, "--1-----") then next_state <= st17; output <= "101000";
        end if;
      when st16 =>
        if std_match(input, "----1-0-") then next_state <= st16; output <= "001100";
        elsif std_match(input, "----1-1-") then next_state <= st7; output <= "001101";
        elsif std_match(input, "1---0---") then next_state <= st11; output <= "011000";
        elsif std_match(input, "0---0---") then next_state <= st9; output <= "001000";
        end if;
      when st17 =>
        if std_match(input, "1----0--") then next_state <= st17; output <= "101000";
        elsif std_match(input, "1----1-0") then next_state <= st17; output <= "101000";
        elsif std_match(input, "0---00--") then next_state <= st8; output <= "000000";
        elsif std_match(input, "0----1-0") then next_state <= st8; output <= "000000";
        elsif std_match(input, "0---01-1") then next_state <= st0; output <= "000001";
        elsif std_match(input, "0---11-1") then next_state <= st1; output <= "000011";
        elsif std_match(input, "1----1-1") then next_state <= st13; output <= "101001";
        elsif std_match(input, "0---10--") then next_state <= st14; output <= "000010";
        end if;
      when st18 =>
        if std_match(input, "----1-1-") then next_state <= st6; output <= "000101";
        elsif std_match(input, "00--0---") then next_state <= st8; output <= "000000";
        elsif std_match(input, "-1-00---") then next_state <= st8; output <= "000000";
        elsif std_match(input, "01-10---") then next_state <= st9; output <= "001000";
        elsif std_match(input, "11-10---") then next_state <= st11; output <= "011000";
        elsif std_match(input, "10--0---") then next_state <= st15; output <= "010000";
        elsif std_match(input, "-1-11-0-") then next_state <= st16; output <= "001100";
        elsif std_match(input, "-0--1-0-") then next_state <= st18; output <= "000100";
        elsif std_match(input, "-1-01-0-") then next_state <= st18; output <= "000100";
        end if;
      when st19 =>
        if std_match(input, "1-0--0--") then next_state <= st19; output <= "100000";
        elsif std_match(input, "1-0--1-0") then next_state <= st19; output <= "100000";
        elsif std_match(input, "0---00--") then next_state <= st8; output <= "000000";
        elsif std_match(input, "0----1-0") then next_state <= st8; output <= "000000";
        elsif std_match(input, "0---01-1") then next_state <= st0; output <= "000001";
        elsif std_match(input, "0---10--") then next_state <= st14; output <= "000010";
        elsif std_match(input, "0---11-1") then next_state <= st1; output <= "000011";
        elsif std_match(input, "1-0--1-1") then next_state <= st12; output <= "100001";
        elsif std_match(input, "1-1-----") then next_state <= st17; output <= "101000";
        end if;
      when others => next_state <= "-----"; output <= "------";
    end case;
  end process;
end behaviour;
