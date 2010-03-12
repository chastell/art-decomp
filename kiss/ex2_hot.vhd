library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity ex2_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end ex2_hot;
architecture behaviour of ex2_hot is
  constant s1: std_logic_vector(18 downto 0) := "1000000000000000000";
  constant s2: std_logic_vector(18 downto 0) := "0100000000000000000";
  constant s4: std_logic_vector(18 downto 0) := "0010000000000000000";
  constant s0: std_logic_vector(18 downto 0) := "0001000000000000000";
  constant s3: std_logic_vector(18 downto 0) := "0000100000000000000";
  constant s6: std_logic_vector(18 downto 0) := "0000010000000000000";
  constant s9: std_logic_vector(18 downto 0) := "0000001000000000000";
  constant s7: std_logic_vector(18 downto 0) := "0000000100000000000";
  constant s8: std_logic_vector(18 downto 0) := "0000000010000000000";
  constant s5: std_logic_vector(18 downto 0) := "0000000001000000000";
  constant s10: std_logic_vector(18 downto 0) := "0000000000100000000";
  constant s11: std_logic_vector(18 downto 0) := "0000000000010000000";
  constant s13: std_logic_vector(18 downto 0) := "0000000000001000000";
  constant s12: std_logic_vector(18 downto 0) := "0000000000000100000";
  constant s15: std_logic_vector(18 downto 0) := "0000000000000010000";
  constant s18: std_logic_vector(18 downto 0) := "0000000000000001000";
  constant s16: std_logic_vector(18 downto 0) := "0000000000000000100";
  constant s17: std_logic_vector(18 downto 0) := "0000000000000000010";
  constant s14: std_logic_vector(18 downto 0) := "0000000000000000001";
  signal current_state, next_state: std_logic_vector(18 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-------------------"; output <= "--";
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
      when others => next_state <= "-------------------"; output <= "--";
    end case;
  end process;
end behaviour;
