library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity ex5_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end ex5_hot;
architecture behaviour of ex5_hot is
  constant s1: std_logic_vector(8 downto 0) := "100000000";
  constant s0: std_logic_vector(8 downto 0) := "010000000";
  constant s7: std_logic_vector(8 downto 0) := "001000000";
  constant s5: std_logic_vector(8 downto 0) := "000100000";
  constant s4: std_logic_vector(8 downto 0) := "000010000";
  constant s2: std_logic_vector(8 downto 0) := "000001000";
  constant s3: std_logic_vector(8 downto 0) := "000000100";
  constant s6: std_logic_vector(8 downto 0) := "000000010";
  constant s8: std_logic_vector(8 downto 0) := "000000001";
  signal current_state, next_state: std_logic_vector(8 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---------"; output <= "--";
    case current_state is
      when s1 =>
        if std_match(input, "00") then next_state <= s0; output <= "--";
        elsif std_match(input, "01") then next_state <= s7; output <= "00";
        elsif std_match(input, "10") then next_state <= s5; output <= "11";
        elsif std_match(input, "11") then next_state <= s4; output <= "--";
        end if;
      when s2 =>
        if std_match(input, "00") then next_state <= s1; output <= "--";
        elsif std_match(input, "01") then next_state <= s4; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "00";
        end if;
      when s3 =>
        if std_match(input, "00") then next_state <= s3; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "00";
        elsif std_match(input, "10") then next_state <= s0; output <= "--";
        elsif std_match(input, "11") then next_state <= s7; output <= "11";
        end if;
      when s4 =>
        if std_match(input, "00") then next_state <= s5; output <= "00";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s1; output <= "--";
        elsif std_match(input, "11") then next_state <= s0; output <= "--";
        end if;
      when s5 =>
        if std_match(input, "00") then next_state <= s0; output <= "11";
        elsif std_match(input, "01") then next_state <= s6; output <= "--";
        elsif std_match(input, "10") then next_state <= s0; output <= "11";
        elsif std_match(input, "11") then next_state <= s0; output <= "11";
        end if;
      when s6 =>
        if std_match(input, "00") then next_state <= s0; output <= "11";
        elsif std_match(input, "01") then next_state <= s5; output <= "--";
        elsif std_match(input, "10") then next_state <= s1; output <= "11";
        elsif std_match(input, "11") then next_state <= s0; output <= "11";
        end if;
      when s7 =>
        if std_match(input, "00") then next_state <= s6; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "11";
        elsif std_match(input, "10") then next_state <= s2; output <= "--";
        elsif std_match(input, "11") then next_state <= s8; output <= "--";
        end if;
      when s8 =>
        if std_match(input, "00") then next_state <= s3; output <= "--";
        elsif std_match(input, "01") then next_state <= s0; output <= "--";
        elsif std_match(input, "10") then next_state <= s1; output <= "00";
        elsif std_match(input, "11") then next_state <= s0; output <= "--";
        end if;
      when others => next_state <= "---------"; output <= "--";
    end case;
  end process;
end behaviour;