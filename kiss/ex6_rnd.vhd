library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity ex6_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(4 downto 0);
    output: out std_logic_vector(7 downto 0)
  );
end ex6_rnd;
architecture behaviour of ex6_rnd is
  constant s1: std_logic_vector(2 downto 0) := "101";
  constant s3: std_logic_vector(2 downto 0) := "010";
  constant s2: std_logic_vector(2 downto 0) := "011";
  constant s4: std_logic_vector(2 downto 0) := "110";
  constant s5: std_logic_vector(2 downto 0) := "111";
  constant s6: std_logic_vector(2 downto 0) := "001";
  constant s7: std_logic_vector(2 downto 0) := "000";
  constant s8: std_logic_vector(2 downto 0) := "100";
  signal current_state, next_state: std_logic_vector(2 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---"; output <= "--------";
    case current_state is
      when s1 =>
        if std_match(input, "11---") then next_state <= s3; output <= "10111000";
        elsif std_match(input, "00---") then next_state <= s2; output <= "11000000";
        elsif std_match(input, "10---") then next_state <= s4; output <= "00101000";
        end if;
      when s2 =>
        if std_match(input, "0-0--") then next_state <= s2; output <= "11000000";
        elsif std_match(input, "--1--") then next_state <= s5; output <= "00001110";
        elsif std_match(input, "110--") then next_state <= s3; output <= "10111000";
        elsif std_match(input, "100--") then next_state <= s4; output <= "00101000";
        end if;
      when s3 =>
        if std_match(input, "10---") then next_state <= s4; output <= "00111000";
        elsif std_match(input, "00---") then next_state <= s2; output <= "11010000";
        elsif std_match(input, "11---") then next_state <= s3; output <= "10111000";
        elsif std_match(input, "01---") then next_state <= s6; output <= "00110101";
        end if;
      when s4 =>
        if std_match(input, "010--") then next_state <= s6; output <= "00100101";
        elsif std_match(input, "--1--") then next_state <= s7; output <= "00101000";
        elsif std_match(input, "110--") then next_state <= s3; output <= "10111000";
        elsif std_match(input, "000--") then next_state <= s2; output <= "11000000";
        elsif std_match(input, "100--") then next_state <= s4; output <= "00101000";
        end if;
      when s5 =>
        if std_match(input, "1-10-") then next_state <= s8; output <= "10000100";
        elsif std_match(input, "--0--") then next_state <= s2; output <= "11000000";
        elsif std_match(input, "--11-") then next_state <= s8; output <= "10000100";
        elsif std_match(input, "0-10-") then next_state <= s5; output <= "00001110";
        end if;
      when s6 =>
        if std_match(input, "----1") then next_state <= s2; output <= "11000001";
        elsif std_match(input, "10--0") then next_state <= s4; output <= "00101001";
        elsif std_match(input, "00--0") then next_state <= s2; output <= "11000001";
        elsif std_match(input, "11--0") then next_state <= s3; output <= "10111001";
        elsif std_match(input, "01--0") then next_state <= s6; output <= "00100101";
        end if;
      when s7 =>
        if std_match(input, "--0--") then next_state <= s2; output <= "11000000";
        elsif std_match(input, "101--") then next_state <= s7; output <= "00101000";
        elsif std_match(input, "011--") then next_state <= s6; output <= "00100101";
        elsif std_match(input, "111--") then next_state <= s3; output <= "10111000";
        elsif std_match(input, "001--") then next_state <= s2; output <= "11000000";
        end if;
      when s8 =>
        if std_match(input, "101--") then next_state <= s7; output <= "00101000";
        elsif std_match(input, "--0--") then next_state <= s2; output <= "11000000";
        elsif std_match(input, "0-1--") then next_state <= s8; output <= "10000100";
        elsif std_match(input, "111--") then next_state <= s3; output <= "10111000";
        end if;
      when others => next_state <= "---"; output <= "--------";
    end case;
  end process;
end behaviour;
