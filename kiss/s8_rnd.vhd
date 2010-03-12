library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s8_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(3 downto 0);
    output: out std_logic_vector(0 downto 0)
  );
end s8_rnd;
architecture behaviour of s8_rnd is
  constant s1: std_logic_vector(2 downto 0) := "101";
  constant s2: std_logic_vector(2 downto 0) := "010";
  constant s3: std_logic_vector(2 downto 0) := "011";
  constant s5: std_logic_vector(2 downto 0) := "110";
  constant s4: std_logic_vector(2 downto 0) := "111";
  signal current_state, next_state: std_logic_vector(2 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---"; output <= "-";
    case current_state is
      when s1 =>
        if std_match(input, "1000") then next_state <= s1; output <= "1";
        elsif std_match(input, "0100") then next_state <= s1; output <= "1";
        elsif std_match(input, "0010") then next_state <= s2; output <= "1";
        elsif std_match(input, "0001") then next_state <= s2; output <= "1";
        end if;
      when s2 =>
        if std_match(input, "1000") then next_state <= s2; output <= "1";
        elsif std_match(input, "0100") then next_state <= s3; output <= "1";
        elsif std_match(input, "0010") then next_state <= s2; output <= "1";
        elsif std_match(input, "0001") then next_state <= s1; output <= "1";
        end if;
      when s3 =>
        if std_match(input, "1000") then next_state <= s3; output <= "1";
        elsif std_match(input, "0100") then next_state <= s5; output <= "1";
        elsif std_match(input, "0010") then next_state <= s3; output <= "1";
        elsif std_match(input, "0001") then next_state <= s5; output <= "1";
        end if;
      when s4 =>
        if std_match(input, "1000") then next_state <= s4; output <= "1";
        elsif std_match(input, "0100") then next_state <= s2; output <= "1";
        elsif std_match(input, "0010") then next_state <= s3; output <= "1";
        elsif std_match(input, "0001") then next_state <= s3; output <= "1";
        end if;
      when s5 =>
        if std_match(input, "1000") then next_state <= s5; output <= "1";
        elsif std_match(input, "0100") then next_state <= s5; output <= "1";
        elsif std_match(input, "0010") then next_state <= s1; output <= "1";
        elsif std_match(input, "0001") then next_state <= s4; output <= "1";
        end if;
      when others => next_state <= "---"; output <= "-";
    end case;
  end process;
end behaviour;
