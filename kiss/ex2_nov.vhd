library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity ex2_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end ex2_nov;
architecture behaviour of ex2_nov is
  constant s1: std_logic_vector(4 downto 0) := "11110";
  constant s2: std_logic_vector(4 downto 0) := "10100";
  constant s3: std_logic_vector(4 downto 0) := "11001";
  constant s4: std_logic_vector(4 downto 0) := "01110";
  constant s5: std_logic_vector(4 downto 0) := "11111";
  constant s6: std_logic_vector(4 downto 0) := "10001";
  constant s7: std_logic_vector(4 downto 0) := "10010";
  constant s8: std_logic_vector(4 downto 0) := "11100";
  constant s9: std_logic_vector(4 downto 0) := "10011";
  constant s10: std_logic_vector(4 downto 0) := "11101";
  constant s11: std_logic_vector(4 downto 0) := "10000";
  constant s12: std_logic_vector(4 downto 0) := "01011";
  constant s13: std_logic_vector(4 downto 0) := "01101";
  constant s14: std_logic_vector(4 downto 0) := "11011";
  constant s15: std_logic_vector(4 downto 0) := "11010";
  constant s16: std_logic_vector(4 downto 0) := "10110";
  constant s17: std_logic_vector(4 downto 0) := "10101";
  constant s18: std_logic_vector(4 downto 0) := "10111";
  constant s0: std_logic_vector(4 downto 0) := "00000";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "--";
    case current_state is
      when s1 =>
        if std_match(input, "00") then next_state <= s2; output <= "--";
        elsif std_match(input, "01") then next_state <= s4; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s3; output <= "--";
        end if;
      when s2 =>
        if std_match(input, "00") then next_state <= s6; output <= "--";
        elsif std_match(input, "01") then next_state <= s9; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "11";
        end if;
      when s3 =>
        if std_match(input, "00") then next_state <= s0; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s7; output <= "--";
        elsif std_match(input, "11") then next_state <= s8; output <= "--";
        end if;
      when s4 =>
        if std_match(input, "00") then next_state <= s2; output <= "--";
        elsif std_match(input, "01") then next_state <= s1; output <= "--";
        elsif std_match(input, "10") then next_state <= s6; output <= "--";
        elsif std_match(input, "11") then next_state <= s5; output <= "--";
        end if;
      when s5 =>
        if std_match(input, "00") then next_state <= s0; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s6; output <= "--";
        end if;
      when s6 =>
        if std_match(input, "00") then next_state <= s1; output <= "00";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s2; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "11";
        end if;
      when s7 =>
        if std_match(input, "00") then next_state <= s5; output <= "11";
        elsif std_match(input, "01") then next_state <= s2; output <= "00";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "--";
        end if;
      when s8 =>
        if std_match(input, "00") then next_state <= s5; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s1; output <= "00";
        end if;
      when s9 =>
        if std_match(input, "00") then next_state <= s5; output <= "--";
        elsif std_match(input, "01") then next_state <= s3; output <= "11";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "--";
        end if;
      when s10 =>
        if std_match(input, "00") then next_state <= s11; output <= "--";
        elsif std_match(input, "01") then next_state <= s13; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s12; output <= "--";
        end if;
      when s11 =>
        if std_match(input, "00") then next_state <= s15; output <= "--";
        elsif std_match(input, "01") then next_state <= s18; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "--";
        end if;
      when s12 =>
        if std_match(input, "00") then next_state <= s0; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s16; output <= "--";
        elsif std_match(input, "11") then next_state <= s17; output <= "--";
        end if;
      when s13 =>
        if std_match(input, "00") then next_state <= s11; output <= "--";
        elsif std_match(input, "01") then next_state <= s10; output <= "00";
        elsif std_match(input, "10") then next_state <= s15; output <= "--";
        elsif std_match(input, "11") then next_state <= s14; output <= "--";
        end if;
      when s14 =>
        if std_match(input, "00") then next_state <= s0; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s15; output <= "--";
        end if;
      when s15 =>
        if std_match(input, "00") then next_state <= s10; output <= "00";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s11; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "11";
        end if;
      when s16 =>
        if std_match(input, "00") then next_state <= s14; output <= "11";
        elsif std_match(input, "01") then next_state <= s11; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "--";
        end if;
      when s17 =>
        if std_match(input, "00") then next_state <= s14; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s10; output <= "00";
        end if;
      when s18 =>
        if std_match(input, "00") then next_state <= s14; output <= "--";
        elsif std_match(input, "01") then next_state <= s12; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "11";
        elsif std_match(input, "11") then next_state <= s0; output <= "--";
        end if;
      when others => next_state <= "-----"; output <= "--";
    end case;
  end process;
end behaviour;
