library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity ex4_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(5 downto 0);
    output: out std_logic_vector(8 downto 0)
  );
end ex4_hot;
architecture behaviour of ex4_hot is
  constant s1: std_logic_vector(13 downto 0) := "10000000000000";
  constant s3: std_logic_vector(13 downto 0) := "01000000000000";
  constant s2: std_logic_vector(13 downto 0) := "00100000000000";
  constant s5: std_logic_vector(13 downto 0) := "00010000000000";
  constant s7: std_logic_vector(13 downto 0) := "00001000000000";
  constant s11: std_logic_vector(13 downto 0) := "00000100000000";
  constant s12: std_logic_vector(13 downto 0) := "00000010000000";
  constant s8: std_logic_vector(13 downto 0) := "00000001000000";
  constant s4: std_logic_vector(13 downto 0) := "00000000100000";
  constant s13: std_logic_vector(13 downto 0) := "00000000010000";
  constant s14: std_logic_vector(13 downto 0) := "00000000001000";
  constant s6: std_logic_vector(13 downto 0) := "00000000000100";
  constant s9: std_logic_vector(13 downto 0) := "00000000000010";
  constant s10: std_logic_vector(13 downto 0) := "00000000000001";
  signal current_state, next_state: std_logic_vector(13 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "--------------"; output <= "---------";
    case current_state is
      when s1 =>
        if std_match(input, "1-----") then next_state <= s3; output <= "110000000";
        end if;
      when s3 =>
        if std_match(input, "1-----") then next_state <= s2; output <= "000000000";
        end if;
      when s2 =>
        if std_match(input, "1-----") then next_state <= s5; output <= "001000000";
        end if;
      when s5 =>
        if std_match(input, "1-----") then next_state <= s7; output <= "000000000";
        end if;
      when s7 =>
        if std_match(input, "10----") then next_state <= s7; output <= "000000000";
        elsif std_match(input, "11----") then next_state <= s11; output <= "100110000";
        end if;
      when s11 =>
        if std_match(input, "1-----") then next_state <= s12; output <= "100100000";
        end if;
      when s12 =>
        if std_match(input, "1-1---") then next_state <= s8; output <= "000001100";
        elsif std_match(input, "1-0---") then next_state <= s8; output <= "000000100";
        end if;
      when s8 =>
        if std_match(input, "1-0---") then next_state <= s3; output <= "110000000";
        elsif std_match(input, "1-10--") then next_state <= s3; output <= "110000000";
        elsif std_match(input, "1-11--") then next_state <= s4; output <= "110000000";
        end if;
      when s4 =>
        if std_match(input, "1---1-") then next_state <= s13; output <= "000000010";
        elsif std_match(input, "1---0-") then next_state <= s13; output <= "000000000";
        end if;
      when s13 =>
        if std_match(input, "1-----") then next_state <= s14; output <= "001000010";
        end if;
      when s14 =>
        if std_match(input, "1-----") then next_state <= s6; output <= "000000000";
        end if;
      when s6 =>
        if std_match(input, "10----") then next_state <= s6; output <= "000000000";
        elsif std_match(input, "11----") then next_state <= s9; output <= "100110000";
        end if;
      when s9 =>
        if std_match(input, "1-----") then next_state <= s10; output <= "100100000";
        end if;
      when s10 =>
        if std_match(input, "1----1") then next_state <= s3; output <= "110000101";
        elsif std_match(input, "1----0") then next_state <= s4; output <= "110000100";
        end if;
      when others => next_state <= "--------------"; output <= "---------";
    end case;
  end process;
end behaviour;
