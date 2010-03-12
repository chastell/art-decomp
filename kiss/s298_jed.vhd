library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s298_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(2 downto 0);
    output: out std_logic_vector(5 downto 0)
  );
end s298_jed;
architecture behaviour of s298_jed is
  constant s00000000000000: std_logic_vector(7 downto 0) := "00110101";
  constant s00000001100000: std_logic_vector(7 downto 0) := "00100101";
  constant s10000001100010: std_logic_vector(7 downto 0) := "00011010";
  constant s10000001100011: std_logic_vector(7 downto 0) := "00010110";
  constant s10000001100001: std_logic_vector(7 downto 0) := "00000110";
  constant s10000001100000: std_logic_vector(7 downto 0) := "00011000";
  constant s01000001100001: std_logic_vector(7 downto 0) := "00100111";
  constant s01000001100000: std_logic_vector(7 downto 0) := "00111001";
  constant s01000001100011: std_logic_vector(7 downto 0) := "00110110";
  constant s01000001100010: std_logic_vector(7 downto 0) := "00111000";
  constant s11001001100011: std_logic_vector(7 downto 0) := "00000000";
  constant s11001001100010: std_logic_vector(7 downto 0) := "00000010";
  constant s11001001100000: std_logic_vector(7 downto 0) := "00010010";
  constant s11001001100001: std_logic_vector(7 downto 0) := "00000100";
  constant s00100001100011: std_logic_vector(7 downto 0) := "01001011";
  constant s00100001100010: std_logic_vector(7 downto 0) := "01011011";
  constant s00100001100001: std_logic_vector(7 downto 0) := "01000001";
  constant s00100001100000: std_logic_vector(7 downto 0) := "01000011";
  constant s10101001100010: std_logic_vector(7 downto 0) := "00110001";
  constant s10101001100011: std_logic_vector(7 downto 0) := "00010011";
  constant s10101001100000: std_logic_vector(7 downto 0) := "01010001";
  constant s10101001100001: std_logic_vector(7 downto 0) := "01010011";
  constant s01101001100010: std_logic_vector(7 downto 0) := "10001010";
  constant s01101001100011: std_logic_vector(7 downto 0) := "10101010";
  constant s01101001100001: std_logic_vector(7 downto 0) := "10001110";
  constant s01101001100000: std_logic_vector(7 downto 0) := "10001100";
  constant s11101001100011: std_logic_vector(7 downto 0) := "11011111";
  constant s11101001100010: std_logic_vector(7 downto 0) := "11011011";
  constant s11101001100000: std_logic_vector(7 downto 0) := "11011101";
  constant s11101001100001: std_logic_vector(7 downto 0) := "11010111";
  constant s00010001100010: std_logic_vector(7 downto 0) := "10100011";
  constant s00010001100011: std_logic_vector(7 downto 0) := "01100001";
  constant s00010001100000: std_logic_vector(7 downto 0) := "11000011";
  constant s00010001100001: std_logic_vector(7 downto 0) := "11000001";
  constant s10010100011010: std_logic_vector(7 downto 0) := "00011101";
  constant s10010100011011: std_logic_vector(7 downto 0) := "00001101";
  constant s10010100011000: std_logic_vector(7 downto 0) := "00001001";
  constant s10010100011001: std_logic_vector(7 downto 0) := "00011111";
  constant s00000000011000: std_logic_vector(7 downto 0) := "01100101";
  constant s00001100000001: std_logic_vector(7 downto 0) := "00001010";
  constant s00001100000000: std_logic_vector(7 downto 0) := "00001000";
  constant s00001100000010: std_logic_vector(7 downto 0) := "00001100";
  constant s00001100000011: std_logic_vector(7 downto 0) := "00001110";
  constant s10000100011001: std_logic_vector(7 downto 0) := "01001101";
  constant s10000100011000: std_logic_vector(7 downto 0) := "01001001";
  constant s10000100011010: std_logic_vector(7 downto 0) := "10001111";
  constant s10000100011011: std_logic_vector(7 downto 0) := "01001111";
  constant s10100001100010: std_logic_vector(7 downto 0) := "01010100";
  constant s10100001100011: std_logic_vector(7 downto 0) := "11010100";
  constant s10100001100001: std_logic_vector(7 downto 0) := "11010000";
  constant s10100001100000: std_logic_vector(7 downto 0) := "01010000";
  constant s01100001100001: std_logic_vector(7 downto 0) := "00101111";
  constant s01100001100000: std_logic_vector(7 downto 0) := "00101101";
  constant s01100001100011: std_logic_vector(7 downto 0) := "00111111";
  constant s01100001100010: std_logic_vector(7 downto 0) := "00101100";
  constant s11101000100110: std_logic_vector(7 downto 0) := "01110111";
  constant s11101000100111: std_logic_vector(7 downto 0) := "01111001";
  constant s11101000100101: std_logic_vector(7 downto 0) := "01110001";
  constant s11101000100100: std_logic_vector(7 downto 0) := "01110101";
  constant s00000000100100: std_logic_vector(7 downto 0) := "00100100";
  constant s00011000100110: std_logic_vector(7 downto 0) := "00001111";
  constant s00011000100111: std_logic_vector(7 downto 0) := "00001011";
  constant s00011000100101: std_logic_vector(7 downto 0) := "00011011";
  constant s00011000100100: std_logic_vector(7 downto 0) := "00000011";
  constant s10011000100100: std_logic_vector(7 downto 0) := "10111010";
  constant s10011000100101: std_logic_vector(7 downto 0) := "10111110";
  constant s10011000100111: std_logic_vector(7 downto 0) := "10110110";
  constant s10011000100110: std_logic_vector(7 downto 0) := "10111100";
  constant s00000000100111: std_logic_vector(7 downto 0) := "00101000";
  constant s00000000100110: std_logic_vector(7 downto 0) := "00100000";
  constant s00000000100101: std_logic_vector(7 downto 0) := "01100100";
  constant s01001001100011: std_logic_vector(7 downto 0) := "01011001";
  constant s01001001100010: std_logic_vector(7 downto 0) := "00010111";
  constant s01001001100000: std_logic_vector(7 downto 0) := "01000111";
  constant s01001001100001: std_logic_vector(7 downto 0) := "10011000";
  constant s11000001100000: std_logic_vector(7 downto 0) := "00011110";
  constant s11000001100001: std_logic_vector(7 downto 0) := "00010000";
  constant s11000001100011: std_logic_vector(7 downto 0) := "00010100";
  constant s11000001100010: std_logic_vector(7 downto 0) := "00011100";
  constant s00011001100001: std_logic_vector(7 downto 0) := "11100010";
  constant s00011001100000: std_logic_vector(7 downto 0) := "10110000";
  constant s00011001100011: std_logic_vector(7 downto 0) := "10100010";
  constant s00011001100010: std_logic_vector(7 downto 0) := "11011000";
  constant s10010001100010: std_logic_vector(7 downto 0) := "11000101";
  constant s10010001100011: std_logic_vector(7 downto 0) := "11001001";
  constant s10010001100001: std_logic_vector(7 downto 0) := "11001101";
  constant s10010001100000: std_logic_vector(7 downto 0) := "11000111";
  constant s10001100011000: std_logic_vector(7 downto 0) := "01101011";
  constant s10001100011001: std_logic_vector(7 downto 0) := "01101111";
  constant s10001100011011: std_logic_vector(7 downto 0) := "01101100";
  constant s10001100011010: std_logic_vector(7 downto 0) := "01101110";
  constant s01001100000001: std_logic_vector(7 downto 0) := "00110010";
  constant s01001100000000: std_logic_vector(7 downto 0) := "00110011";
  constant s01001100000010: std_logic_vector(7 downto 0) := "00111011";
  constant s01001100000011: std_logic_vector(7 downto 0) := "00111010";
  constant s11000100011001: std_logic_vector(7 downto 0) := "11001110";
  constant s11000100011000: std_logic_vector(7 downto 0) := "11011010";
  constant s11000100011010: std_logic_vector(7 downto 0) := "11001100";
  constant s11000100011011: std_logic_vector(7 downto 0) := "11011110";
  constant s00101100000000: std_logic_vector(7 downto 0) := "10001101";
  constant s00101100000001: std_logic_vector(7 downto 0) := "10000100";
  constant s00101100000010: std_logic_vector(7 downto 0) := "10011101";
  constant s00101100000011: std_logic_vector(7 downto 0) := "10000101";
  constant s10101100011001: std_logic_vector(7 downto 0) := "11000000";
  constant s10101100011000: std_logic_vector(7 downto 0) := "11000010";
  constant s10101100011010: std_logic_vector(7 downto 0) := "10000010";
  constant s10101100011011: std_logic_vector(7 downto 0) := "11000100";
  constant s10100100011011: std_logic_vector(7 downto 0) := "01111110";
  constant s10100100011010: std_logic_vector(7 downto 0) := "01111010";
  constant s10100100011001: std_logic_vector(7 downto 0) := "01111000";
  constant s10100100011000: std_logic_vector(7 downto 0) := "01111100";
  constant s00100100000011: std_logic_vector(7 downto 0) := "01100000";
  constant s00100100000010: std_logic_vector(7 downto 0) := "00110000";
  constant s00100100000001: std_logic_vector(7 downto 0) := "01110000";
  constant s00100100000000: std_logic_vector(7 downto 0) := "01110100";
  constant s11001100011000: std_logic_vector(7 downto 0) := "01100010";
  constant s11001100011001: std_logic_vector(7 downto 0) := "00100010";
  constant s11001100011010: std_logic_vector(7 downto 0) := "11001010";
  constant s11001100011011: std_logic_vector(7 downto 0) := "01101010";
  constant s01000100000000: std_logic_vector(7 downto 0) := "10010101";
  constant s01000100000001: std_logic_vector(7 downto 0) := "10010001";
  constant s01000100000010: std_logic_vector(7 downto 0) := "00010101";
  constant s01000100000011: std_logic_vector(7 downto 0) := "10000001";
  constant s00001010010001: std_logic_vector(7 downto 0) := "00101010";
  constant s00001010010000: std_logic_vector(7 downto 0) := "01001110";
  constant s00001010010011: std_logic_vector(7 downto 0) := "01001010";
  constant s00001010010010: std_logic_vector(7 downto 0) := "01011010";
  constant s00000010010000: std_logic_vector(7 downto 0) := "00100001";
  constant s10000000011010: std_logic_vector(7 downto 0) := "11010101";
  constant s10000000011011: std_logic_vector(7 downto 0) := "11010001";
  constant s10000000011001: std_logic_vector(7 downto 0) := "11011001";
  constant s10000000011000: std_logic_vector(7 downto 0) := "11010011";
  constant s00101001100010: std_logic_vector(7 downto 0) := "11010010";
  constant s00101001100011: std_logic_vector(7 downto 0) := "01110110";
  constant s00101001100000: std_logic_vector(7 downto 0) := "01110010";
  constant s00101001100001: std_logic_vector(7 downto 0) := "01010010";
  constant s10001000011000: std_logic_vector(7 downto 0) := "11001011";
  constant s10001000011001: std_logic_vector(7 downto 0) := "11001111";
  constant s10001000011011: std_logic_vector(7 downto 0) := "11101110";
  constant s10001000011010: std_logic_vector(7 downto 0) := "11011100";
  constant s01001000011011: std_logic_vector(7 downto 0) := "00100110";
  constant s01001000011010: std_logic_vector(7 downto 0) := "01101000";
  constant s01001000011001: std_logic_vector(7 downto 0) := "01100110";
  constant s01001000011000: std_logic_vector(7 downto 0) := "11001000";
  constant s01000000011011: std_logic_vector(7 downto 0) := "10001001";
  constant s01000000011010: std_logic_vector(7 downto 0) := "11000110";
  constant s01000000011001: std_logic_vector(7 downto 0) := "10001000";
  constant s01000000011000: std_logic_vector(7 downto 0) := "10000110";
  constant s10011001100001: std_logic_vector(7 downto 0) := "01111111";
  constant s10011001100000: std_logic_vector(7 downto 0) := "01101101";
  constant s10011001100011: std_logic_vector(7 downto 0) := "01100111";
  constant s10011001100010: std_logic_vector(7 downto 0) := "01111101";
  constant s00000001100001: std_logic_vector(7 downto 0) := "00111101";
  constant s00000001100010: std_logic_vector(7 downto 0) := "00110100";
  constant s00000001100011: std_logic_vector(7 downto 0) := "00110111";
  constant s10001001100000: std_logic_vector(7 downto 0) := "00000111";
  constant s10001001100001: std_logic_vector(7 downto 0) := "01011000";
  constant s10001001100010: std_logic_vector(7 downto 0) := "01000110";
  constant s10001001100011: std_logic_vector(7 downto 0) := "00011001";
  constant s10011010010000: std_logic_vector(7 downto 0) := "10100100";
  constant s10011010010001: std_logic_vector(7 downto 0) := "10101100";
  constant s10011010010010: std_logic_vector(7 downto 0) := "10100000";
  constant s10011010010011: std_logic_vector(7 downto 0) := "10101000";
  constant s00000010010011: std_logic_vector(7 downto 0) := "00101011";
  constant s00000010010010: std_logic_vector(7 downto 0) := "00101001";
  constant s00000010010001: std_logic_vector(7 downto 0) := "00100011";
  constant s10010010010011: std_logic_vector(7 downto 0) := "01110011";
  constant s10010010010010: std_logic_vector(7 downto 0) := "01111011";
  constant s10010010010000: std_logic_vector(7 downto 0) := "01101001";
  constant s10010010010001: std_logic_vector(7 downto 0) := "01100011";
  constant s10011100011000: std_logic_vector(7 downto 0) := "01000010";
  constant s10011100011001: std_logic_vector(7 downto 0) := "00010001";
  constant s10011100011011: std_logic_vector(7 downto 0) := "00000001";
  constant s10011100011010: std_logic_vector(7 downto 0) := "00000101";
  constant s00000100000010: std_logic_vector(7 downto 0) := "10010100";
  constant s00000100000011: std_logic_vector(7 downto 0) := "10010010";
  constant s00000100000000: std_logic_vector(7 downto 0) := "10010000";
  constant s00000100000001: std_logic_vector(7 downto 0) := "10000000";
  constant s11100001100001: std_logic_vector(7 downto 0) := "10101001";
  constant s11100001100000: std_logic_vector(7 downto 0) := "10101111";
  constant s11100001100010: std_logic_vector(7 downto 0) := "10100111";
  constant s11100001100011: std_logic_vector(7 downto 0) := "10101011";
  constant s10010000100111: std_logic_vector(7 downto 0) := "11101010";
  constant s10010000100110: std_logic_vector(7 downto 0) := "10100110";
  constant s10010000100101: std_logic_vector(7 downto 0) := "11101000";
  constant s10010000100100: std_logic_vector(7 downto 0) := "11100110";
  constant s00010000100100: std_logic_vector(7 downto 0) := "01001100";
  constant s00010000100101: std_logic_vector(7 downto 0) := "01000000";
  constant s00010000100110: std_logic_vector(7 downto 0) := "01001000";
  constant s00010000100111: std_logic_vector(7 downto 0) := "01000100";
  constant s11100000100111: std_logic_vector(7 downto 0) := "10110010";
  constant s11100000100110: std_logic_vector(7 downto 0) := "10111000";
  constant s11100000100100: std_logic_vector(7 downto 0) := "10011001";
  constant s11100000100101: std_logic_vector(7 downto 0) := "10110100";
  constant s01100100000010: std_logic_vector(7 downto 0) := "10001011";
  constant s01100100000011: std_logic_vector(7 downto 0) := "10000111";
  constant s01100100000001: std_logic_vector(7 downto 0) := "10000011";
  constant s01100100000000: std_logic_vector(7 downto 0) := "10010011";
  constant s11100100011011: std_logic_vector(7 downto 0) := "01011101";
  constant s11100100011010: std_logic_vector(7 downto 0) := "01011111";
  constant s11100100011001: std_logic_vector(7 downto 0) := "01011100";
  constant s11100100011000: std_logic_vector(7 downto 0) := "01011110";
  constant s00011100000001: std_logic_vector(7 downto 0) := "10010110";
  constant s00011100000000: std_logic_vector(7 downto 0) := "10011110";
  constant s00011100000010: std_logic_vector(7 downto 0) := "11010110";
  constant s00011100000011: std_logic_vector(7 downto 0) := "10010111";
  constant s00010100000000: std_logic_vector(7 downto 0) := "10011011";
  constant s00010100000001: std_logic_vector(7 downto 0) := "10011100";
  constant s00010100000010: std_logic_vector(7 downto 0) := "10011010";
  constant s00010100000011: std_logic_vector(7 downto 0) := "10011111";
  constant s11101100011001: std_logic_vector(7 downto 0) := "01010110";
  constant s11101100011000: std_logic_vector(7 downto 0) := "01010101";
  constant s11101100011010: std_logic_vector(7 downto 0) := "01000101";
  constant s11101100011011: std_logic_vector(7 downto 0) := "01010111";
  constant s01101100000000: std_logic_vector(7 downto 0) := "00111110";
  constant s01101100000001: std_logic_vector(7 downto 0) := "00101110";
  constant s01101100000011: std_logic_vector(7 downto 0) := "00111100";
  constant s01101100000010: std_logic_vector(7 downto 0) := "10101110";
  signal current_state, next_state: std_logic_vector(7 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "--------"; output <= "------";
    case current_state is
      when s00000000000000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10000001100010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10000001100011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10000001100001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10000001100000; output <= "000000";
        end if;
      when s00000001100000 =>
        if std_match(input, "000") then next_state <= s10000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10000001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10000001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10000001100011; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10000001100000 =>
        if std_match(input, "010") then next_state <= s01000001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01000001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01000001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01000001100001 =>
        if std_match(input, "001") then next_state <= s11001001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11001001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11001001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11001001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s11001001100011 =>
        if std_match(input, "000") then next_state <= s00100001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00100001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00100001100001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00100001100000; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00100001100011 =>
        if std_match(input, "010") then next_state <= s10101001100010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10101001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10101001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10101001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10101001100010 =>
        if std_match(input, "000") then next_state <= s01101001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01101001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01101001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01101001100000; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01101001100010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11101001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11101001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11101001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11101001100001; output <= "100001";
        end if;
      when s11101001100011 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00010001100010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00010001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00010001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00010001100001; output <= "100001";
        end if;
      when s00010001100010 =>
        if std_match(input, "000") then next_state <= s10010100011010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10010100011011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10010100011000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10010100011001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "100001";
        end if;
      when s10010100011010 =>
        if std_match(input, "011") then next_state <= s00001100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00001100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00001100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00001100000011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s00001100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10000100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10000100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10000100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10000100011011; output <= "000000";
        end if;
      when s00000000011000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s10000001100010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s10000001100011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s10000001100000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s10000001100001; output <= "010100";
        end if;
      when s10000001100010 =>
        if std_match(input, "010") then next_state <= s01000001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01000001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01000001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01000001100000; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01000001100011 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11001001100001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11001001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11001001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11001001100010; output <= "100001";
        end if;
      when s11001001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00100001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00100001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00100001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00100001100010; output <= "100001";
        end if;
      when s00100001100000 =>
        if std_match(input, "001") then next_state <= s10100001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10100001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10100001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10100001100000; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10100001100010 =>
        if std_match(input, "011") then next_state <= s01100001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01100001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01100001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01100001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01100001100001 =>
        if std_match(input, "011") then next_state <= s11101000100110; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11101000100111; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11101000100101; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11101000100100; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        end if;
      when s11101000100110 =>
        if std_match(input, "000") then next_state <= s00011000100110; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00011000100111; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00011000100101; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00011000100100; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s00011000100110 =>
        if std_match(input, "001") then next_state <= s10011000100100; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10011000100101; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10011000100111; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10011000100110; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s10011000100100 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00000000100111; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00000000100110; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00000000100101; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s00000000100100 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10000001100010; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10000001100011; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10000001100000; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10000001100001; output <= "100010";
        end if;
      when s10000001100011 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01001001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01001001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01001001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01001001100001; output <= "100001";
        end if;
      when s01001001100011 =>
        if std_match(input, "011") then next_state <= s11000001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11000001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11000001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11000001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s11000001100000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00100001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00100001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00100001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00100001100000; output <= "100001";
        end if;
      when s00100001100010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10100001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10100001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10100001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10100001100001; output <= "100001";
        end if;
      when s10100001100011 =>
        if std_match(input, "011") then next_state <= s01101001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01101001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01101001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01101001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01101001100000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11101001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11101001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11101001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11101001100000; output <= "100001";
        end if;
      when s11101001100010 =>
        if std_match(input, "011") then next_state <= s00011001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00011001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00011001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00011001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00011001100001 =>
        if std_match(input, "011") then next_state <= s10010001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10010001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10010001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10010001100000; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10010001100010 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00001100000010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00001100000011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00001100000001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00001100000000; output <= "100001";
        end if;
      when s00001100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10001100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10001100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10001100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10001100011010; output <= "000000";
        end if;
      when s10001100011000 =>
        if std_match(input, "010") then next_state <= s01001100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01001100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01001100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01001100000011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s01001100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11000100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11000100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11000100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11000100011011; output <= "000000";
        end if;
      when s11000100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00101100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00101100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00101100000010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00101100000011; output <= "010100";
        end if;
      when s00101100000000 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10101100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10101100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10101100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10101100011011; output <= "000000";
        end if;
      when s00101100000001 =>
        if std_match(input, "001") then next_state <= s10100100011011; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10100100011010; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10100100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10100100011000; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s00101100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10101100011001; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10101100011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10101100011010; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10101100011011; output <= "000000";
        end if;
      when s00101100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10100100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10100100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10100100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10100100011010; output <= "000000";
        end if;
      when s11000100011000 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00100100000011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00100100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00100100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00100100000000; output <= "010100";
        end if;
      when s00100100000011 =>
        if std_match(input, "011") then next_state <= s10101100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10101100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10101100011010; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10101100011011; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s00100100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10100100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10100100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10100100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10100100011010; output <= "000000";
        end if;
      when s00100100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10101100011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10101100011001; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10101100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10101100011011; output <= "000000";
        end if;
      when s00100100000000 =>
        if std_match(input, "000") then next_state <= s10100100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10100100011001; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10100100011011; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10100100011010; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s11000100011010 =>
        if std_match(input, "011") then next_state <= s00100100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00100100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00100100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00100100000011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s11000100011011 =>
        if std_match(input, "010") then next_state <= s00101100000010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00101100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00101100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00101100000001; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s01001100000000 =>
        if std_match(input, "000") then next_state <= s11001100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11001100011001; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11001100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11001100011011; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s11001100011000 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00101100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00101100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00101100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00101100000011; output <= "010100";
        end if;
      when s11001100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00100100000001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00100100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00100100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00100100000010; output <= "010100";
        end if;
      when s11001100011010 =>
        if std_match(input, "000") then next_state <= s00101100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00101100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00101100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00101100000000; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s11001100011011 =>
        if std_match(input, "001") then next_state <= s00100100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00100100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00100100000011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00100100000010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s01001100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11001100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11001100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11001100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11001100011001; output <= "000000";
        end if;
      when s01001100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11000100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11000100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11000100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11000100011010; output <= "000000";
        end if;
      when s10001100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01000100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000100000010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01000100000011; output <= "010100";
        end if;
      when s01000100000000 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11000100011011; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11000100011010; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11000100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11000100011001; output <= "000000";
        end if;
      when s01000100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11001100011011; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11001100011010; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11001100011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11001100011001; output <= "000000";
        end if;
      when s01000100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11000100011001; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11000100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11000100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11000100011010; output <= "000000";
        end if;
      when s01000100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11001100011001; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11001100011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11001100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11001100011010; output <= "000000";
        end if;
      when s10001100011011 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000100000010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01000100000011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01000100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000100000000; output <= "010100";
        end if;
      when s10001100011010 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01001100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01001100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01001100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01001100000011; output <= "010100";
        end if;
      when s00001100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10000100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10000100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10000100011010; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10000100011011; output <= "000000";
        end if;
      when s10000100011000 =>
        if std_match(input, "001") then next_state <= s01000100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000100000011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01000100000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000100000001; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s10000100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01001100000010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01001100000011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01001100000001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01001100000000; output <= "010100";
        end if;
      when s10000100011010 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01000100000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01000100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000100000011; output <= "010100";
        end if;
      when s10000100011011 =>
        if std_match(input, "011") then next_state <= s01001100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01001100000001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01001100000010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01001100000011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s00001100000000 =>
        if std_match(input, "011") then next_state <= s10001100011011; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10001100011010; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10001100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10001100011001; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s10010001100011 =>
        if std_match(input, "001") then next_state <= s00001100000001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00001100000000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00001100000010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00001100000011; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "100001";
        end if;
      when s10010001100001 =>
        if std_match(input, "000") then next_state <= s00001010010001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00001010010000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00001010010011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00001010010010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000010010000; output <= "100001";
        end if;
      when s00001010010001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s10000000011010; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10000000011011; output <= "001100";
        elsif std_match(input, "000") then next_state <= s10000000011001; output <= "001100";
        elsif std_match(input, "010") then next_state <= s10000000011000; output <= "001100";
        end if;
      when s10000000011010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01000001100010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000001100011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01000001100000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000001100001; output <= "010100";
        end if;
      when s01000001100010 =>
        if std_match(input, "000") then next_state <= s11000001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11000001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11000001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11000001100000; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s11000001100010 =>
        if std_match(input, "000") then next_state <= s00100001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00100001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00100001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00100001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00100001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10101001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10101001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10101001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10101001100000; output <= "100001";
        end if;
      when s11000001100011 =>
        if std_match(input, "010") then next_state <= s00101001100010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00101001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00101001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00101001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00101001100010 =>
        if std_match(input, "001") then next_state <= s10101001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10101001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10101001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10101001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00101001100011 =>
        if std_match(input, "011") then next_state <= s10100001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10100001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10100001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10100001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00101001100000 =>
        if std_match(input, "001") then next_state <= s10101001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10101001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10101001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10101001100000; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00101001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10100001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10100001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10100001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10100001100001; output <= "100001";
        end if;
      when s11000001100001 =>
        if std_match(input, "001") then next_state <= s00101001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00101001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00101001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00101001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01000001100000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11000001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11000001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11000001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11000001100011; output <= "100001";
        end if;
      when s10000000011011 =>
        if std_match(input, "001") then next_state <= s01001001100001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01001001100000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01001001100010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01001001100011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        end if;
      when s01001001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11000001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11000001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11000001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11000001100010; output <= "100001";
        end if;
      when s01001001100000 =>
        if std_match(input, "010") then next_state <= s11001001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11001001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11001001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11001001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s11001001100000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00101001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00101001100010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00101001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00101001100001; output <= "100001";
        end if;
      when s11001001100010 =>
        if std_match(input, "001") then next_state <= s00101001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00101001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00101001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00101001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01001001100010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11001001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11001001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11001001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11001001100011; output <= "100001";
        end if;
      when s10000000011001 =>
        if std_match(input, "010") then next_state <= s01001001100000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01001001100001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01001001100011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01001001100010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        end if;
      when s10000000011000 =>
        if std_match(input, "000") then next_state <= s01000001100000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000001100001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000001100011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01000001100010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        end if;
      when s00001010010000 =>
        if std_match(input, "000") then next_state <= s10001000011000; output <= "001100";
        elsif std_match(input, "010") then next_state <= s10001000011001; output <= "001100";
        elsif std_match(input, "011") then next_state <= s10001000011011; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10001000011010; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "001100";
        end if;
      when s10001000011000 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01001000011011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01001000011010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01001000011001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01001000011000; output <= "010100";
        end if;
      when s01001000011011 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11000001100011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s11000001100010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s11000001100001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11000001100000; output <= "010100";
        end if;
      when s01001000011010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11001001100010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s11001001100011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s11001001100000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11001001100001; output <= "010100";
        end if;
      when s01001000011001 =>
        if std_match(input, "001") then next_state <= s11000001100011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11000001100010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11000001100001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s11000001100000; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        end if;
      when s01001000011000 =>
        if std_match(input, "010") then next_state <= s11001001100001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11001001100000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11001001100011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s11001001100010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        end if;
      when s10001000011001 =>
        if std_match(input, "001") then next_state <= s01000000011011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000000011010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01000000011001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000000011000; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "010100";
        end if;
      when s01000000011011 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s11001001100001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11001001100000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s11001001100010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11001001100011; output <= "010100";
        end if;
      when s01000000011010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s11000001100011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11000001100010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s11000001100000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11000001100001; output <= "010100";
        end if;
      when s01000000011001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s11001001100011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11001001100010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11001001100001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s11001001100000; output <= "010100";
        end if;
      when s01000000011000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s11000001100000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s11000001100001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s11000001100010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s11000001100011; output <= "010100";
        end if;
      when s10001000011011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01000000011010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01000000011011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01000000011001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01000000011000; output <= "010100";
        end if;
      when s10001000011010 =>
        if std_match(input, "000") then next_state <= s01001000011010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01001000011011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01001000011001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01001000011000; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "010100";
        end if;
      when s00001010010011 =>
        if std_match(input, "010") then next_state <= s10000000011010; output <= "001100";
        elsif std_match(input, "000") then next_state <= s10000000011011; output <= "001100";
        elsif std_match(input, "011") then next_state <= s10000000011000; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10000000011001; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "001100";
        end if;
      when s00001010010010 =>
        if std_match(input, "000") then next_state <= s10001000011010; output <= "001100";
        elsif std_match(input, "010") then next_state <= s10001000011011; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10001000011000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s10001000011001; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "001100";
        end if;
      when s00000010010000 =>
        if std_match(input, "011") then next_state <= s10000001100011; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10000001100010; output <= "001100";
        elsif std_match(input, "010") then next_state <= s10000001100001; output <= "001100";
        elsif std_match(input, "000") then next_state <= s10000001100000; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "001100";
        end if;
      when s10000001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01001001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01001001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01001001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01001001100000; output <= "100001";
        end if;
      when s10010001100000 =>
        if std_match(input, "010") then next_state <= s00001010010001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00001010010000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00001010010011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00001010010010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000010010000; output <= "100001";
        end if;
      when s00011001100000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10011001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10011001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10011001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10011001100010; output <= "100001";
        end if;
      when s10011001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00000001100001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00000001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00000001100011; output <= "100001";
        end if;
      when s00000001100001 =>
        if std_match(input, "010") then next_state <= s10001001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10001001100001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10001001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10001001100011; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10001001100000 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01001000011010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01001000011011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01001000011001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01001000011000; output <= "100001";
        end if;
      when s10001001100001 =>
        if std_match(input, "000") then next_state <= s01000000011001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01000000011000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01000000011010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01000000011011; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "100001";
        end if;
      when s10001001100010 =>
        if std_match(input, "010") then next_state <= s01001000011011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01001000011010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01001000011000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01001000011001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "100001";
        end if;
      when s10001001100011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01000000011011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01000000011010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01000000011000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01000000011001; output <= "100001";
        end if;
      when s00000001100010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10000001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10000001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10000001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10000001100000; output <= "100001";
        end if;
      when s00000001100011 =>
        if std_match(input, "011") then next_state <= s10001001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10001001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10001001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10001001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10011001100000 =>
        if std_match(input, "1-1") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00000001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00000001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00000001100001; output <= "100001";
        elsif std_match(input, "110") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "-00") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10011001100011 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00000001100010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00000001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00000001100001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10011001100010 =>
        if std_match(input, "000") then next_state <= s00000001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00000001100011; output <= "100001";
        elsif std_match(input, "1-0") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "1-1") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00000001100001; output <= "100001";
        end if;
      when s00011001100011 =>
        if std_match(input, "011") then next_state <= s10010001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10010001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10010001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10010001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00011001100010 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10011001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10011001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10011001100010; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10011001100011; output <= "100001";
        end if;
      when s11101001100001 =>
        if std_match(input, "000") then next_state <= s00010001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00010001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00010001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00010001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s00010001100001 =>
        if std_match(input, "1--") then next_state <= s00000010010000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10011010010000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10011010010001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10011010010010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10011010010011; output <= "100001";
        end if;
      when s10011010010000 =>
        if std_match(input, "011") then next_state <= s00000010010011; output <= "001100";
        elsif std_match(input, "001") then next_state <= s00000010010010; output <= "001100";
        elsif std_match(input, "1-1") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "1-0") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "010") then next_state <= s00000010010001; output <= "001100";
        elsif std_match(input, "000") then next_state <= s00000010010000; output <= "001100";
        end if;
      when s00000010010011 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s10001001100000; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10001001100001; output <= "001100";
        elsif std_match(input, "010") then next_state <= s10001001100010; output <= "001100";
        elsif std_match(input, "000") then next_state <= s10001001100011; output <= "001100";
        end if;
      when s00000010010010 =>
        if std_match(input, "011") then next_state <= s10000001100001; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10000001100000; output <= "001100";
        elsif std_match(input, "000") then next_state <= s10000001100010; output <= "001100";
        elsif std_match(input, "010") then next_state <= s10000001100011; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "001100";
        end if;
      when s00000010010001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "001100";
        elsif std_match(input, "000") then next_state <= s10001001100001; output <= "001100";
        elsif std_match(input, "010") then next_state <= s10001001100000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s10001001100010; output <= "001100";
        elsif std_match(input, "001") then next_state <= s10001001100011; output <= "001100";
        end if;
      when s10011010010001 =>
        if std_match(input, "001") then next_state <= s00000010010011; output <= "001100";
        elsif std_match(input, "011") then next_state <= s00000010010010; output <= "001100";
        elsif std_match(input, "1-1") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "000") then next_state <= s00000010010001; output <= "001100";
        elsif std_match(input, "100") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "-10") then next_state <= s00000010010000; output <= "001100";
        end if;
      when s10011010010010 =>
        if std_match(input, "000") then next_state <= s00000010010010; output <= "001100";
        elsif std_match(input, "010") then next_state <= s00000010010011; output <= "001100";
        elsif std_match(input, "1-0") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "111") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s00000010010001; output <= "001100";
        elsif std_match(input, "-01") then next_state <= s00000010010000; output <= "001100";
        end if;
      when s10011010010011 =>
        if std_match(input, "1--") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s00000010010000; output <= "001100";
        elsif std_match(input, "001") then next_state <= s00000010010001; output <= "001100";
        elsif std_match(input, "000") then next_state <= s00000010010011; output <= "001100";
        elsif std_match(input, "010") then next_state <= s00000010010010; output <= "001100";
        end if;
      when s00010001100000 =>
        if std_match(input, "011") then next_state <= s10010010010011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10010010010010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10010010010000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10010010010001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000010010000; output <= "100001";
        end if;
      when s10010010010011 =>
        if std_match(input, "000") then next_state <= s00001100000011; output <= "001100";
        elsif std_match(input, "010") then next_state <= s00001100000010; output <= "001100";
        elsif std_match(input, "011") then next_state <= s00001100000000; output <= "001100";
        elsif std_match(input, "001") then next_state <= s00001100000001; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "001100";
        end if;
      when s10010010010010 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "001100";
        elsif std_match(input, "001") then next_state <= s00001100000000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s00001100000001; output <= "001100";
        elsif std_match(input, "000") then next_state <= s00001100000010; output <= "001100";
        elsif std_match(input, "010") then next_state <= s00001100000011; output <= "001100";
        end if;
      when s10010010010000 =>
        if std_match(input, "010") then next_state <= s00001010010001; output <= "001100";
        elsif std_match(input, "000") then next_state <= s00001010010000; output <= "001100";
        elsif std_match(input, "011") then next_state <= s00001010010011; output <= "001100";
        elsif std_match(input, "001") then next_state <= s00001010010010; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000010010000; output <= "001100";
        end if;
      when s10010010010001 =>
        if std_match(input, "010") then next_state <= s00001010010000; output <= "001100";
        elsif std_match(input, "000") then next_state <= s00001010010001; output <= "001100";
        elsif std_match(input, "011") then next_state <= s00001010010010; output <= "001100";
        elsif std_match(input, "001") then next_state <= s00001010010011; output <= "001100";
        elsif std_match(input, "1--") then next_state <= s00000010010000; output <= "001100";
        end if;
      when s00010001100011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s10011100011000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s10011100011001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s10011100011011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s10011100011010; output <= "100001";
        end if;
      when s10011100011000 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00000100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00000100000011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00000100000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00000100000001; output <= "010100";
        end if;
      when s00000100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10000100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10000100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10000100011001; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10000100011000; output <= "000000";
        end if;
      when s00000100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10001100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10001100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10001100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10001100011010; output <= "000000";
        end if;
      when s00000100000000 =>
        if std_match(input, "001") then next_state <= s10000100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10000100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10000100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10000100011001; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s00000100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10001100011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10001100011001; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10001100011011; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10001100011010; output <= "000000";
        end if;
      when s10011100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00000100000010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00000100000011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00000100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00000100000001; output <= "010100";
        end if;
      when s10011100011011 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00000100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00000100000001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00000100000010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00000100000011; output <= "010100";
        end if;
      when s10011100011010 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00000100000011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00000100000010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00000100000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00000100000001; output <= "010100";
        end if;
      when s11101001100000 =>
        if std_match(input, "011") then next_state <= s00011001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00011001100010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00011001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00011001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01101001100001 =>
        if std_match(input, "000") then next_state <= s11100001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11100001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11100001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11100001100011; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s11100001100001 =>
        if std_match(input, "001") then next_state <= s00011000100111; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00011000100110; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00011000100100; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00011000100101; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        end if;
      when s00011000100111 =>
        if std_match(input, "000") then next_state <= s10010000100111; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10010000100110; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10010000100101; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10010000100100; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s10010000100111 =>
        if std_match(input, "000") then next_state <= s00001100000011; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00001100000010; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00001100000001; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00001100000000; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "100010";
        end if;
      when s10010000100110 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00001100000010; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00001100000011; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00001100000000; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00001100000001; output <= "100010";
        end if;
      when s10010000100101 =>
        if std_match(input, "010") then next_state <= s00001010010000; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00001010010001; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00001010010011; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00001010010010; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000010010000; output <= "100010";
        end if;
      when s10010000100100 =>
        if std_match(input, "1--") then next_state <= s00000010010000; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00001010010000; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00001010010001; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00001010010011; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00001010010010; output <= "100010";
        end if;
      when s00011000100100 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10011000100110; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10011000100111; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10011000100101; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10011000100100; output <= "100010";
        end if;
      when s10011000100110 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00000000100101; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00000000100110; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00000000100111; output <= "100010";
        end if;
      when s00000000100101 =>
        if std_match(input, "001") then next_state <= s10001001100011; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10001001100010; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10001001100000; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10001001100001; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100010";
        end if;
      when s00000000100110 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10000001100011; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10000001100010; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10000001100001; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10000001100000; output <= "100010";
        end if;
      when s00000000100111 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10001001100001; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10001001100000; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10001001100010; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10001001100011; output <= "100010";
        end if;
      when s10011000100111 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00000000100111; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00000000100110; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00000000100101; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s10011000100101 =>
        if std_match(input, "011") then next_state <= s00000000100110; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00000000100111; output <= "100010";
        elsif std_match(input, "1-1") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "1-0") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00000000100101; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s00011000100101 =>
        if std_match(input, "000") then next_state <= s10010000100101; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10010000100100; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10010000100110; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10010000100111; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s11100001100000 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00010000100100; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00010000100101; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00010000100110; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00010000100111; output <= "100001";
        end if;
      when s00010000100100 =>
        if std_match(input, "1--") then next_state <= s00000010010000; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10010010010010; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10010010010011; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10010010010000; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10010010010001; output <= "100010";
        end if;
      when s00010000100101 =>
        if std_match(input, "1--") then next_state <= s00000010010000; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10011010010000; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10011010010001; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10011010010011; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10011010010010; output <= "100010";
        end if;
      when s00010000100110 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10010100011000; output <= "100010";
        elsif std_match(input, "011") then next_state <= s10010100011001; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10010100011011; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10010100011010; output <= "100010";
        end if;
      when s10010100011000 =>
        if std_match(input, "010") then next_state <= s00001100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00001100000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00001100000011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00001100000010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s10010100011001 =>
        if std_match(input, "010") then next_state <= s00001100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00001100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00001100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00001100000010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s10010100011011 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00001100000011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00001100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00001100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00001100000001; output <= "010100";
        end if;
      when s00010000100111 =>
        if std_match(input, "011") then next_state <= s10011100011000; output <= "100010";
        elsif std_match(input, "001") then next_state <= s10011100011001; output <= "100010";
        elsif std_match(input, "010") then next_state <= s10011100011010; output <= "100010";
        elsif std_match(input, "000") then next_state <= s10011100011011; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "100010";
        end if;
      when s11100001100010 =>
        if std_match(input, "001") then next_state <= s00010000100100; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00010000100101; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00010000100111; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00010000100110; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        end if;
      when s11100001100011 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        elsif std_match(input, "001") then next_state <= s00011000100101; output <= "100001";
        elsif std_match(input, "011") then next_state <= s00011000100100; output <= "100001";
        elsif std_match(input, "000") then next_state <= s00011000100111; output <= "100001";
        elsif std_match(input, "010") then next_state <= s00011000100110; output <= "100001";
        end if;
      when s01101001100011 =>
        if std_match(input, "000") then next_state <= s11100001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11100001100010; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11100001100000; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11100001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10100001100000 =>
        if std_match(input, "011") then next_state <= s01100001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01100001100010; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01100001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01100001100001; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s01100001100011 =>
        if std_match(input, "010") then next_state <= s11101000100110; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11101000100111; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11101000100100; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11101000100101; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        end if;
      when s11101000100111 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00010000100110; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00010000100111; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00010000100101; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00010000100100; output <= "100010";
        end if;
      when s11101000100100 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00011000100100; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00011000100101; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00011000100111; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00011000100110; output <= "100010";
        end if;
      when s11101000100101 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00010000100110; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00010000100111; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00010000100101; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00010000100100; output <= "100010";
        end if;
      when s01100001100010 =>
        if std_match(input, "010") then next_state <= s11100000100111; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11100000100110; output <= "100001";
        elsif std_match(input, "001") then next_state <= s11100000100100; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11100000100101; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        end if;
      when s11100000100111 =>
        if std_match(input, "011") then next_state <= s00011000100100; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00011000100101; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00011000100110; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00011000100111; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s11100000100110 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00010000100110; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00010000100111; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00010000100100; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00010000100101; output <= "100010";
        end if;
      when s11100000100100 =>
        if std_match(input, "011") then next_state <= s00010000100111; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00010000100110; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00010000100100; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00010000100101; output <= "100010";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        end if;
      when s11100000100101 =>
        if std_match(input, "1--") then next_state <= s00000000100100; output <= "100010";
        elsif std_match(input, "011") then next_state <= s00011000100110; output <= "100010";
        elsif std_match(input, "001") then next_state <= s00011000100111; output <= "100010";
        elsif std_match(input, "000") then next_state <= s00011000100101; output <= "100010";
        elsif std_match(input, "010") then next_state <= s00011000100100; output <= "100010";
        end if;
      when s01100001100000 =>
        if std_match(input, "001") then next_state <= s11100000100110; output <= "100001";
        elsif std_match(input, "011") then next_state <= s11100000100111; output <= "100001";
        elsif std_match(input, "000") then next_state <= s11100000100100; output <= "100001";
        elsif std_match(input, "010") then next_state <= s11100000100101; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000000100100; output <= "100001";
        end if;
      when s10100001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01101001100010; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01101001100011; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01101001100001; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01101001100000; output <= "100001";
        end if;
      when s10101001100011 =>
        if std_match(input, "001") then next_state <= s01100001100001; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01100001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01100001100011; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01100001100010; output <= "100001";
        elsif std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        end if;
      when s10101001100000 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01101001100001; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01101001100000; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01101001100011; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01101001100010; output <= "100001";
        end if;
      when s10101001100001 =>
        if std_match(input, "1--") then next_state <= s00000001100000; output <= "100001";
        elsif std_match(input, "010") then next_state <= s01100001100000; output <= "100001";
        elsif std_match(input, "000") then next_state <= s01100001100001; output <= "100001";
        elsif std_match(input, "001") then next_state <= s01100001100011; output <= "100001";
        elsif std_match(input, "011") then next_state <= s01100001100010; output <= "100001";
        end if;
      when s10100100011000 =>
        if std_match(input, "001") then next_state <= s01100100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01100100000011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01100100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01100100000000; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s01100100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11100100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11100100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11100100011001; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11100100011000; output <= "000000";
        end if;
      when s11100100011011 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00011100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00011100000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00011100000010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00011100000011; output <= "010100";
        end if;
      when s00011100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10010100011011; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10010100011010; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10010100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10010100011000; output <= "000000";
        end if;
      when s00011100000000 =>
        if std_match(input, "000") then next_state <= s10011100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10011100011001; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10011100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10011100011011; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s00011100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10011100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10011100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10011100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10011100011001; output <= "000000";
        end if;
      when s00011100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10010100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10010100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10010100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10010100011010; output <= "000000";
        end if;
      when s11100100011010 =>
        if std_match(input, "001") then next_state <= s00010100000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00010100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00010100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00010100000011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s00010100000000 =>
        if std_match(input, "010") then next_state <= s10010100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10010100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10010100011011; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10010100011010; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s00010100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10011100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10011100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10011100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10011100011000; output <= "000000";
        end if;
      when s00010100000010 =>
        if std_match(input, "001") then next_state <= s10010100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10010100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s10010100011010; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10010100011011; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s00010100000011 =>
        if std_match(input, "000") then next_state <= s10011100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s10011100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s10011100011001; output <= "000000";
        elsif std_match(input, "011") then next_state <= s10011100011000; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s11100100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00011100000001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00011100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00011100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00011100000010; output <= "010100";
        end if;
      when s11100100011000 =>
        if std_match(input, "010") then next_state <= s00010100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00010100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00010100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00010100000011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s01100100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11101100011001; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11101100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11101100011010; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11101100011011; output <= "000000";
        end if;
      when s11101100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00010100000010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00010100000011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00010100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00010100000001; output <= "010100";
        end if;
      when s11101100011000 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00011100000010; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00011100000011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00011100000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00011100000001; output <= "010100";
        end if;
      when s11101100011010 =>
        if std_match(input, "011") then next_state <= s00011100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00011100000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00011100000011; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00011100000010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s11101100011011 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s00010100000011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s00010100000010; output <= "010100";
        elsif std_match(input, "001") then next_state <= s00010100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s00010100000000; output <= "010100";
        end if;
      when s01100100000001 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11101100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11101100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11101100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11101100011011; output <= "000000";
        end if;
      when s01100100000000 =>
        if std_match(input, "000") then next_state <= s11100100011000; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11100100011001; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11100100011011; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11100100011010; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s10100100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01101100000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01101100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01101100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01101100000010; output <= "010100";
        end if;
      when s01101100000000 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11101100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11101100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11101100011001; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11101100011000; output <= "000000";
        end if;
      when s01101100000001 =>
        if std_match(input, "011") then next_state <= s11100100011010; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11100100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11100100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11100100011000; output <= "000000";
        elsif std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        end if;
      when s01101100000011 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11100100011011; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11100100011010; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11100100011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11100100011001; output <= "000000";
        end if;
      when s01101100000010 =>
        if std_match(input, "1--") then next_state <= s00000000011000; output <= "000000";
        elsif std_match(input, "001") then next_state <= s11101100011000; output <= "000000";
        elsif std_match(input, "011") then next_state <= s11101100011001; output <= "000000";
        elsif std_match(input, "010") then next_state <= s11101100011011; output <= "000000";
        elsif std_match(input, "000") then next_state <= s11101100011010; output <= "000000";
        end if;
      when s10100100011011 =>
        if std_match(input, "011") then next_state <= s01101100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01101100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01101100000011; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01101100000010; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s10100100011010 =>
        if std_match(input, "001") then next_state <= s01100100000000; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01100100000001; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01100100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01100100000011; output <= "010100";
        elsif std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        end if;
      when s10101100011000 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01101100000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01101100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01101100000011; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01101100000010; output <= "010100";
        end if;
      when s10101100011001 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01100100000001; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01100100000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01100100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01100100000010; output <= "010100";
        end if;
      when s10101100011010 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01101100000010; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01101100000011; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01101100000001; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01101100000000; output <= "010100";
        end if;
      when s10101100011011 =>
        if std_match(input, "1--") then next_state <= s00000000000000; output <= "010100";
        elsif std_match(input, "001") then next_state <= s01100100000001; output <= "010100";
        elsif std_match(input, "011") then next_state <= s01100100000000; output <= "010100";
        elsif std_match(input, "010") then next_state <= s01100100000010; output <= "010100";
        elsif std_match(input, "000") then next_state <= s01100100000011; output <= "010100";
        end if;
      when others => next_state <= "--------"; output <= "------";
    end case;
  end process;
end behaviour;
