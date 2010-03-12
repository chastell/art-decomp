library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity bbsse_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(6 downto 0);
    output: out std_logic_vector(6 downto 0)
  );
end bbsse_hot;
architecture behaviour of bbsse_hot is
  constant st0: std_logic_vector(15 downto 0) := "1000000000000000";
  constant st1: std_logic_vector(15 downto 0) := "0100000000000000";
  constant st11: std_logic_vector(15 downto 0) := "0010000000000000";
  constant st4: std_logic_vector(15 downto 0) := "0001000000000000";
  constant st2: std_logic_vector(15 downto 0) := "0000100000000000";
  constant st3: std_logic_vector(15 downto 0) := "0000010000000000";
  constant st5: std_logic_vector(15 downto 0) := "0000001000000000";
  constant st6: std_logic_vector(15 downto 0) := "0000000100000000";
  constant st7: std_logic_vector(15 downto 0) := "0000000010000000";
  constant st8: std_logic_vector(15 downto 0) := "0000000001000000";
  constant st9: std_logic_vector(15 downto 0) := "0000000000100000";
  constant st10: std_logic_vector(15 downto 0) := "0000000000010000";
  constant st12: std_logic_vector(15 downto 0) := "0000000000001000";
  constant st13: std_logic_vector(15 downto 0) := "0000000000000100";
  constant st14: std_logic_vector(15 downto 0) := "0000000000000010";
  constant st15: std_logic_vector(15 downto 0) := "0000000000000001";
  signal current_state, next_state: std_logic_vector(15 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "----------------"; output <= "-------";
    case current_state is
      when st0 =>
        if std_match(input, "0------") then next_state <= st0; output <= "0000000";
        elsif std_match(input, "10----0") then next_state <= st1; output <= "00110-0";
        elsif std_match(input, "10----1") then next_state <= st1; output <= "00010-0";
        elsif std_match(input, "11----0") then next_state <= st11; output <= "0011010";
        elsif std_match(input, "11----1") then next_state <= st11; output <= "0001010";
        end if;
      when st1 =>
        if std_match(input, "100----") then next_state <= st1; output <= "00000-0";
        elsif std_match(input, "101-1--") then next_state <= st4; output <= "10000-0";
        elsif std_match(input, "101-0--") then next_state <= st2; output <= "10000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st2 =>
        if std_match(input, "10-----") then next_state <= st3; output <= "00000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st3 =>
        if std_match(input, "10--0--") then next_state <= st2; output <= "10000-0";
        elsif std_match(input, "10--1--") then next_state <= st4; output <= "10000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st4 =>
        if std_match(input, "10-----") then next_state <= st5; output <= "00000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st5 =>
        if std_match(input, "10-1---") then next_state <= st4; output <= "10000-0";
        elsif std_match(input, "10--1--") then next_state <= st4; output <= "10000-0";
        elsif std_match(input, "10-00--") then next_state <= st6; output <= "0100010";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st6 =>
        if std_match(input, "10---0-") then next_state <= st6; output <= "0100000";
        elsif std_match(input, "10---1-") then next_state <= st7; output <= "01000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st7 =>
        if std_match(input, "10-----") then next_state <= st8; output <= "0000010";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st8 =>
        if std_match(input, "10---0-") then next_state <= st8; output <= "0000000";
        elsif std_match(input, "10---1-") then next_state <= st9; output <= "10000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st9 =>
        if std_match(input, "10-----") then next_state <= st10; output <= "00000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st10 =>
        if std_match(input, "1001---") then next_state <= st10; output <= "00000-0";
        elsif std_match(input, "10-01--") then next_state <= st1; output <= "00010-0";
        elsif std_match(input, "10-00--") then next_state <= st6; output <= "0100010";
        elsif std_match(input, "1011---") then next_state <= st9; output <= "10000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        elsif std_match(input, "11-----") then next_state <= st11; output <= "0000010";
        end if;
      when st11 =>
        if std_match(input, "0----0-") then next_state <= st11; output <= "000--00";
        elsif std_match(input, "11---0-") then next_state <= st11; output <= "0000000";
        elsif std_match(input, "0----1-") then next_state <= st0; output <= "000---1";
        elsif std_match(input, "10-----") then next_state <= st1; output <= "00000-0";
        elsif std_match(input, "11---1-") then next_state <= st12; output <= "00001-0";
        end if;
      when st12 =>
        if std_match(input, "11-----") then next_state <= st12; output <= "00001-0";
        elsif std_match(input, "10-----") then next_state <= st1; output <= "00000-0";
        elsif std_match(input, "0------") then next_state <= st11; output <= "000--10";
        end if;
      when st13 =>
        if std_match(input, "0------") then next_state <= st11; output <= "000--10";
        end if;
      when st14 =>
        if std_match(input, "0------") then next_state <= st11; output <= "000--10";
        end if;
      when st15 =>
        if std_match(input, "0------") then next_state <= st11; output <= "000--10";
        end if;
      when others => next_state <= "----------------"; output <= "-------";
    end case;
  end process;
end behaviour;
