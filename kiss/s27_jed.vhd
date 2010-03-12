library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s27_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(3 downto 0);
    output: out std_logic_vector(0 downto 0)
  );
end s27_jed;
architecture behaviour of s27_jed is
  constant s000: std_logic_vector(2 downto 0) := "110";
  constant s001: std_logic_vector(2 downto 0) := "100";
  constant s101: std_logic_vector(2 downto 0) := "000";
  constant s100: std_logic_vector(2 downto 0) := "010";
  constant s010: std_logic_vector(2 downto 0) := "011";
  constant s011: std_logic_vector(2 downto 0) := "001";
  signal current_state, next_state: std_logic_vector(2 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---"; output <= "-";
    case current_state is
      when s000 =>
        if std_match(input, "010-") then next_state <= s001; output <= "1";
        elsif std_match(input, "011-") then next_state <= s000; output <= "1";
        elsif std_match(input, "110-") then next_state <= s101; output <= "1";
        elsif std_match(input, "111-") then next_state <= s100; output <= "1";
        elsif std_match(input, "10-0") then next_state <= s100; output <= "1";
        elsif std_match(input, "00-0") then next_state <= s000; output <= "1";
        elsif std_match(input, "-0-1") then next_state <= s010; output <= "0";
        end if;
      when s001 =>
        if std_match(input, "0-0-") then next_state <= s001; output <= "1";
        elsif std_match(input, "0-1-") then next_state <= s000; output <= "1";
        elsif std_match(input, "1-0-") then next_state <= s101; output <= "1";
        elsif std_match(input, "1-1-") then next_state <= s100; output <= "1";
        end if;
      when s101 =>
        if std_match(input, "0-0-") then next_state <= s001; output <= "1";
        elsif std_match(input, "0-1-") then next_state <= s000; output <= "1";
        elsif std_match(input, "1-0-") then next_state <= s101; output <= "1";
        elsif std_match(input, "1-1-") then next_state <= s100; output <= "1";
        end if;
      when s100 =>
        if std_match(input, "010-") then next_state <= s001; output <= "1";
        elsif std_match(input, "011-") then next_state <= s000; output <= "1";
        elsif std_match(input, "00--") then next_state <= s000; output <= "1";
        elsif std_match(input, "111-") then next_state <= s100; output <= "1";
        elsif std_match(input, "110-") then next_state <= s101; output <= "1";
        elsif std_match(input, "10--") then next_state <= s100; output <= "1";
        end if;
      when s010 =>
        if std_match(input, "0-1-") then next_state <= s010; output <= "0";
        elsif std_match(input, "000-") then next_state <= s010; output <= "0";
        elsif std_match(input, "010-") then next_state <= s011; output <= "0";
        elsif std_match(input, "1101") then next_state <= s101; output <= "1";
        elsif std_match(input, "1111") then next_state <= s100; output <= "1";
        elsif std_match(input, "10-1") then next_state <= s010; output <= "0";
        elsif std_match(input, "1100") then next_state <= s101; output <= "1";
        elsif std_match(input, "1110") then next_state <= s100; output <= "1";
        elsif std_match(input, "10-0") then next_state <= s100; output <= "1";
        end if;
      when s011 =>
        if std_match(input, "0-0-") then next_state <= s011; output <= "0";
        elsif std_match(input, "0-1-") then next_state <= s010; output <= "0";
        elsif std_match(input, "1-1-") then next_state <= s100; output <= "1";
        elsif std_match(input, "1-0-") then next_state <= s101; output <= "1";
        end if;
      when others => next_state <= "---"; output <= "-";
    end case;
  end process;
end behaviour;
