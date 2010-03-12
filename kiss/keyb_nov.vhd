library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity keyb_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(6 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end keyb_nov;
architecture behaviour of keyb_nov is
  constant st0: std_logic_vector(4 downto 0) := "00000";
  constant st1: std_logic_vector(4 downto 0) := "00100";
  constant st2: std_logic_vector(4 downto 0) := "01100";
  constant st3: std_logic_vector(4 downto 0) := "00001";
  constant st4: std_logic_vector(4 downto 0) := "00101";
  constant st5: std_logic_vector(4 downto 0) := "01101";
  constant st6: std_logic_vector(4 downto 0) := "00111";
  constant st7: std_logic_vector(4 downto 0) := "00110";
  constant st8: std_logic_vector(4 downto 0) := "01110";
  constant st9: std_logic_vector(4 downto 0) := "00011";
  constant st10: std_logic_vector(4 downto 0) := "00010";
  constant st11: std_logic_vector(4 downto 0) := "01000";
  constant st12: std_logic_vector(4 downto 0) := "01001";
  constant st13: std_logic_vector(4 downto 0) := "01111";
  constant st14: std_logic_vector(4 downto 0) := "01010";
  constant st15: std_logic_vector(4 downto 0) := "10101";
  constant st16: std_logic_vector(4 downto 0) := "01011";
  constant st17: std_logic_vector(4 downto 0) := "11010";
  constant st18: std_logic_vector(4 downto 0) := "10100";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "--";
    case current_state is
      when st0 =>
        if std_match(input, "---0000") then next_state <= st1; output <= "1-";
        elsif std_match(input, "---0100") then next_state <= st2; output <= "1-";
        elsif std_match(input, "---0010") then next_state <= st2; output <= "1-";
        elsif std_match(input, "---0001") then next_state <= st2; output <= "1-";
        elsif std_match(input, "---1100") then next_state <= st3; output <= "1-";
        elsif std_match(input, "---1000") then next_state <= st3; output <= "1-";
        elsif std_match(input, "---011-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---01-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---101-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---10-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---111-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---11-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st1 =>
        if std_match(input, "0000000") then next_state <= st4; output <= "1-";
        elsif std_match(input, "1000000") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0100000") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0010000") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0001000") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0000100") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0000010") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0000001") then next_state <= st5; output <= "0-";
        elsif std_match(input, "11-----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "1-1----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "1--1---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "1---1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "1----1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "1-----1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-11----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1-1---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1--1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1---1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1----1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1-1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1--1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1---1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---11--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1-1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1--1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----11-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st2 =>
        if std_match(input, "0000000") then next_state <= st5; output <= "--";
        elsif std_match(input, "1------") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1-----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "------1") then next_state <= st0; output <= "-0";
        end if;
      when st3 =>
        if std_match(input, "0000000") then next_state <= st6; output <= "1-";
        elsif std_match(input, "0011000") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0000100") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0000010") then next_state <= st5; output <= "0-";
        elsif std_match(input, "0000001") then next_state <= st5; output <= "0-";
        elsif std_match(input, "1------") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1-----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--01---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--10---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--111--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11-1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11--1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----11-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st4 =>
        if std_match(input, "-000000") then next_state <= st7; output <= "1-";
        elsif std_match(input, "-100000") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-010000") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-001000") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-000100") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-000010") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-000001") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-11----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1-1---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1--1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1---1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-1----1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1-1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1--1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1---1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---11--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1-1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1--1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----11-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st5 =>
        if std_match(input, "-000000") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-1-----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "------1") then next_state <= st0; output <= "-0";
        end if;
      when st6 =>
        if std_match(input, "-011000") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-000100") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-000010") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-000001") then next_state <= st8; output <= "0-";
        elsif std_match(input, "-000000") then next_state <= st9; output <= "1-";
        elsif std_match(input, "-1-----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--01---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--10---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--111--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11-1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11--1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----11-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st7 =>
        if std_match(input, "--00000") then next_state <= st10; output <= "1-";
        elsif std_match(input, "--10000") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--01000") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--00100") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--00010") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--00001") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--11---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1-1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1--1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--1---1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---11--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1-1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1--1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----11-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st8 =>
        if std_match(input, "--00000") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--1----") then next_state <= st0; output <= "-0";
        elsif std_match(input, "---1---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "------1") then next_state <= st0; output <= "-0";
        end if;
      when st9 =>
        if std_match(input, "--00000") then next_state <= st12; output <= "--";
        elsif std_match(input, "--11000") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--00100") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--00010") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--00001") then next_state <= st11; output <= "0-";
        elsif std_match(input, "--01---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--10---") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--111--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11-1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "--11--1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----11-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st10 =>
        if std_match(input, "----000") then next_state <= st13; output <= "1-";
        elsif std_match(input, "----100") then next_state <= st14; output <= "0-";
        elsif std_match(input, "----010") then next_state <= st14; output <= "0-";
        elsif std_match(input, "----001") then next_state <= st14; output <= "0-";
        elsif std_match(input, "----11-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "----1-1") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st11 =>
        if std_match(input, "----000") then next_state <= st14; output <= "0-";
        elsif std_match(input, "----1--") then next_state <= st0; output <= "-0";
        elsif std_match(input, "-----1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "------1") then next_state <= st0; output <= "-0";
        end if;
      when st12 =>
        if std_match(input, "-----00") then next_state <= st14; output <= "--";
        elsif std_match(input, "-----1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "------1") then next_state <= st0; output <= "-0";
        end if;
      when st13 =>
        if std_match(input, "-----00") then next_state <= st15; output <= "1-";
        elsif std_match(input, "-----10") then next_state <= st16; output <= "0-";
        elsif std_match(input, "-----01") then next_state <= st16; output <= "0-";
        elsif std_match(input, "-----11") then next_state <= st0; output <= "-0";
        end if;
      when st14 =>
        if std_match(input, "-----00") then next_state <= st16; output <= "0-";
        elsif std_match(input, "-----1-") then next_state <= st0; output <= "-0";
        elsif std_match(input, "------1") then next_state <= st0; output <= "-0";
        end if;
      when st15 =>
        if std_match(input, "------0") then next_state <= st17; output <= "--";
        elsif std_match(input, "------1") then next_state <= st18; output <= "0-";
        end if;
      when st16 =>
        if std_match(input, "------0") then next_state <= st18; output <= "0-";
        elsif std_match(input, "------1") then next_state <= st0; output <= "-0";
        end if;
      when st17 =>
        if std_match(input, "-------") then next_state <= st0; output <= "-0";
        end if;
      when st18 =>
        if std_match(input, "-------") then next_state <= st0; output <= "-1";
        end if;
      when others => next_state <= "-----"; output <= "--";
    end case;
  end process;
end behaviour;
