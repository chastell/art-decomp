library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity dk17_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(2 downto 0)
  );
end dk17_nov;
architecture behaviour of dk17_nov is
  constant s10000000: std_logic_vector(2 downto 0) := "001";
  constant s01000000: std_logic_vector(2 downto 0) := "101";
  constant s00100000: std_logic_vector(2 downto 0) := "000";
  constant s00010000: std_logic_vector(2 downto 0) := "011";
  constant s00001000: std_logic_vector(2 downto 0) := "100";
  constant s00000100: std_logic_vector(2 downto 0) := "110";
  constant s00000010: std_logic_vector(2 downto 0) := "010";
  constant s00000001: std_logic_vector(2 downto 0) := "111";
  signal current_state, next_state: std_logic_vector(2 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---"; output <= "---";
    case current_state is
      when s10000000 =>
        if std_match(input, "00") then next_state <= s10000000; output <= "001";
        elsif std_match(input, "01") then next_state <= s00010000; output <= "010";
        elsif std_match(input, "10") then next_state <= s01000000; output <= "001";
        elsif std_match(input, "11") then next_state <= s00001000; output <= "010";
        end if;
      when s01000000 =>
        if std_match(input, "00") then next_state <= s00100000; output <= "000";
        elsif std_match(input, "01") then next_state <= s00010000; output <= "000";
        elsif std_match(input, "10") then next_state <= s00100000; output <= "010";
        elsif std_match(input, "11") then next_state <= s00000100; output <= "000";
        end if;
      when s00100000 =>
        if std_match(input, "00") then next_state <= s10000000; output <= "001";
        elsif std_match(input, "01") then next_state <= s10000000; output <= "101";
        elsif std_match(input, "10") then next_state <= s01000000; output <= "001";
        elsif std_match(input, "11") then next_state <= s01000000; output <= "101";
        end if;
      when s00010000 =>
        if std_match(input, "00") then next_state <= s00010000; output <= "100";
        elsif std_match(input, "01") then next_state <= s00001000; output <= "101";
        elsif std_match(input, "10") then next_state <= s00010000; output <= "010";
        elsif std_match(input, "11") then next_state <= s00001000; output <= "101";
        end if;
      when s00001000 =>
        if std_match(input, "00") then next_state <= s00100000; output <= "000";
        elsif std_match(input, "01") then next_state <= s00010000; output <= "100";
        elsif std_match(input, "10") then next_state <= s00100000; output <= "010";
        elsif std_match(input, "11") then next_state <= s00100000; output <= "100";
        end if;
      when s00000100 =>
        if std_match(input, "00") then next_state <= s00000010; output <= "000";
        elsif std_match(input, "01") then next_state <= s00000001; output <= "000";
        elsif std_match(input, "10") then next_state <= s00100000; output <= "010";
        elsif std_match(input, "11") then next_state <= s00100000; output <= "100";
        end if;
      when s00000010 =>
        if std_match(input, "00") then next_state <= s00010000; output <= "010";
        elsif std_match(input, "01") then next_state <= s10000000; output <= "101";
        elsif std_match(input, "10") then next_state <= s00001000; output <= "010";
        elsif std_match(input, "11") then next_state <= s01000000; output <= "101";
        end if;
      when s00000001 =>
        if std_match(input, "00") then next_state <= s00010000; output <= "100";
        elsif std_match(input, "01") then next_state <= s00001000; output <= "100";
        elsif std_match(input, "10") then next_state <= s00100000; output <= "010";
        elsif std_match(input, "11") then next_state <= s00100000; output <= "100";
        end if;
      when others => next_state <= "---"; output <= "---";
    end case;
  end process;
end behaviour;
