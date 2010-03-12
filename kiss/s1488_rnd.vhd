library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s1488_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(7 downto 0);
    output: out std_logic_vector(18 downto 0)
  );
end s1488_rnd;
architecture behaviour of s1488_rnd is
  constant s000000: std_logic_vector(5 downto 0) := "111101";
  constant s001110: std_logic_vector(5 downto 0) := "000010";
  constant s011000: std_logic_vector(5 downto 0) := "011011";
  constant s010000: std_logic_vector(5 downto 0) := "111110";
  constant s010100: std_logic_vector(5 downto 0) := "111111";
  constant s110011: std_logic_vector(5 downto 0) := "010001";
  constant s010011: std_logic_vector(5 downto 0) := "010110";
  constant s000100: std_logic_vector(5 downto 0) := "001011";
  constant s100011: std_logic_vector(5 downto 0) := "001111";
  constant s010110: std_logic_vector(5 downto 0) := "011110";
  constant s010111: std_logic_vector(5 downto 0) := "101011";
  constant s000111: std_logic_vector(5 downto 0) := "100001";
  constant s101011: std_logic_vector(5 downto 0) := "110000";
  constant s001111: std_logic_vector(5 downto 0) := "101111";
  constant s111100: std_logic_vector(5 downto 0) := "011010";
  constant s101100: std_logic_vector(5 downto 0) := "111000";
  constant s001100: std_logic_vector(5 downto 0) := "110110";
  constant s010001: std_logic_vector(5 downto 0) := "001000";
  constant s011011: std_logic_vector(5 downto 0) := "000001";
  constant s110110: std_logic_vector(5 downto 0) := "100100";
  constant s011111: std_logic_vector(5 downto 0) := "001001";
  constant s101110: std_logic_vector(5 downto 0) := "101001";
  constant s010101: std_logic_vector(5 downto 0) := "100110";
  constant s111110: std_logic_vector(5 downto 0) := "111011";
  constant s000011: std_logic_vector(5 downto 0) := "011100";
  constant s111010: std_logic_vector(5 downto 0) := "100011";
  constant s011010: std_logic_vector(5 downto 0) := "100010";
  constant s111011: std_logic_vector(5 downto 0) := "011000";
  constant s100000: std_logic_vector(5 downto 0) := "000011";
  constant s101000: std_logic_vector(5 downto 0) := "110111";
  constant s110000: std_logic_vector(5 downto 0) := "010011";
  constant s011110: std_logic_vector(5 downto 0) := "110010";
  constant s010010: std_logic_vector(5 downto 0) := "000111";
  constant s001010: std_logic_vector(5 downto 0) := "001100";
  constant s000010: std_logic_vector(5 downto 0) := "110101";
  constant s111000: std_logic_vector(5 downto 0) := "010100";
  constant s100100: std_logic_vector(5 downto 0) := "000000";
  constant s001000: std_logic_vector(5 downto 0) := "100111";
  constant s001011: std_logic_vector(5 downto 0) := "011101";
  constant s110100: std_logic_vector(5 downto 0) := "101101";
  constant s100110: std_logic_vector(5 downto 0) := "100101";
  constant s011101: std_logic_vector(5 downto 0) := "100000";
  constant s000110: std_logic_vector(5 downto 0) := "111100";
  constant s110010: std_logic_vector(5 downto 0) := "000100";
  constant s011100: std_logic_vector(5 downto 0) := "110011";
  constant s101010: std_logic_vector(5 downto 0) := "010111";
  constant s100010: std_logic_vector(5 downto 0) := "111010";
  constant s100111: std_logic_vector(5 downto 0) := "111001";
  signal current_state, next_state: std_logic_vector(5 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "------"; output <= "-------------------";
    case current_state is
      when s000000 =>
        if std_match(input, "0-11----") then next_state <= s000000; output <= "0100011010010010111";
        elsif std_match(input, "0-01----") then next_state <= s000000; output <= "0000000011000100000";
        elsif std_match(input, "1-11----") then next_state <= s001110; output <= "0100011010010010111";
        elsif std_match(input, "1-01----") then next_state <= s000000; output <= "0000000011000100000";
        elsif std_match(input, "--00----") then next_state <= s000000; output <= "0000000010000110000";
        elsif std_match(input, "--10----") then next_state <= s000000; output <= "0000000000000000000";
        end if;
      when s001110 =>
        if std_match(input, "00------") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "01--1---") then next_state <= s000000; output <= "0010100010001110000";
        elsif std_match(input, "01--0---") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1---0---") then next_state <= s011000; output <= "0000001010001010000";
        elsif std_match(input, "10--1---") then next_state <= s011000; output <= "0000001010001010000";
        elsif std_match(input, "11--1---") then next_state <= s010000; output <= "0010100010001110000";
        end if;
      when s011000 =>
        if std_match(input, "0-10-010") then next_state <= s000000; output <= "0000010000000000000";
        elsif std_match(input, "0-10-000") then next_state <= s000000; output <= "0000010000000000001";
        elsif std_match(input, "0-10-100") then next_state <= s000000; output <= "0000010000000000101";
        elsif std_match(input, "0-10-110") then next_state <= s000000; output <= "0000010000000000100";
        elsif std_match(input, "0-11-1-0") then next_state <= s000000; output <= "0000011000011011101";
        elsif std_match(input, "0-11-0-0") then next_state <= s000000; output <= "0000011000011011001";
        elsif std_match(input, "0-00-100") then next_state <= s000000; output <= "0000000000001111101";
        elsif std_match(input, "0-00-110") then next_state <= s000000; output <= "0000000000001111100";
        elsif std_match(input, "0-00-000") then next_state <= s000000; output <= "0000000000001111001";
        elsif std_match(input, "0-00-010") then next_state <= s000000; output <= "0000000000001111000";
        elsif std_match(input, "0-01-100") then next_state <= s000000; output <= "0000010001001101101";
        elsif std_match(input, "0-01-110") then next_state <= s000000; output <= "0000010001001101100";
        elsif std_match(input, "0-01-010") then next_state <= s000000; output <= "0000010001001101000";
        elsif std_match(input, "0-01-000") then next_state <= s000000; output <= "0000010001001101001";
        elsif std_match(input, "0-----01") then next_state <= s000000; output <= "0000001100111010011";
        elsif std_match(input, "0-----11") then next_state <= s000000; output <= "0000001100111010010";
        elsif std_match(input, "1-----11") then next_state <= s010100; output <= "0000001100111010010";
        elsif std_match(input, "1-----01") then next_state <= s010100; output <= "0000001100111010011";
        elsif std_match(input, "1-01-100") then next_state <= s010100; output <= "0000010001001101101";
        elsif std_match(input, "1-01-110") then next_state <= s010100; output <= "0000010001001101100";
        elsif std_match(input, "1-01-000") then next_state <= s010100; output <= "0000010001001101001";
        elsif std_match(input, "1-01-010") then next_state <= s010100; output <= "0000010001001101000";
        elsif std_match(input, "1-11-1-0") then next_state <= s110011; output <= "0000011000011011101";
        elsif std_match(input, "1-11-0-0") then next_state <= s110011; output <= "0000011000011011001";
        elsif std_match(input, "1-00-100") then next_state <= s010100; output <= "0000000000001111101";
        elsif std_match(input, "1-00-110") then next_state <= s010100; output <= "0000000000001111100";
        elsif std_match(input, "1-00-000") then next_state <= s010100; output <= "0000000000001111001";
        elsif std_match(input, "1-00-010") then next_state <= s010100; output <= "0000000000001111000";
        elsif std_match(input, "1-10-000") then next_state <= s010100; output <= "0000010000000000001";
        elsif std_match(input, "1-10-010") then next_state <= s010100; output <= "0000010000000000000";
        elsif std_match(input, "1-10-110") then next_state <= s010100; output <= "0000010000000000100";
        elsif std_match(input, "1-10-100") then next_state <= s010100; output <= "0000010000000000101";
        end if;
      when s010100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1-------") then next_state <= s010011; output <= "0000001010001010000";
        end if;
      when s010011 =>
        if std_match(input, "1----0--") then next_state <= s000100; output <= "0000001010000110011";
        elsif std_match(input, "1----1--") then next_state <= s000100; output <= "0000001010000110111";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000001010000110011";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001010000110111";
        end if;
      when s000100 =>
        if std_match(input, "11---01-") then next_state <= s100011; output <= "0000001010001010000";
        elsif std_match(input, "01---01-") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "11--111-") then next_state <= s010110; output <= "0000001010001010000";
        elsif std_match(input, "11--011-") then next_state <= s010111; output <= "0000001010001010000";
        elsif std_match(input, "01---11-") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "10----1-") then next_state <= s010111; output <= "0000001010001010000";
        elsif std_match(input, "00----1-") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "0-----0-") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1-----0-") then next_state <= s010111; output <= "0000001010001010000";
        end if;
      when s100011 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001000011011001";
        elsif std_match(input, "1-------") then next_state <= s110011; output <= "0000001000011011001";
        end if;
      when s110011 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1-------") then next_state <= s000111; output <= "0000001010001010000";
        end if;
      when s000111 =>
        if std_match(input, "0----0--") then next_state <= s000000; output <= "0000001000011011010";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001000011011110";
        elsif std_match(input, "1----1--") then next_state <= s101011; output <= "0000001000011011110";
        elsif std_match(input, "1----0--") then next_state <= s101011; output <= "0000001000011011010";
        end if;
      when s101011 =>
        if std_match(input, "1-------") then next_state <= s001111; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s001111 =>
        if std_match(input, "1----0--") then next_state <= s000100; output <= "0001000000101011011";
        elsif std_match(input, "1----1--") then next_state <= s000100; output <= "0001000000101011111";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0001000000101011111";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0001000000101011011";
        end if;
      when s010110 =>
        if std_match(input, "1----1--") then next_state <= s111100; output <= "0100001010010010111";
        elsif std_match(input, "1-11-0--") then next_state <= s110011; output <= "0000011000011011001";
        elsif std_match(input, "1-01-0--") then next_state <= s101100; output <= "0000010001001101000";
        elsif std_match(input, "1-00-0--") then next_state <= s101100; output <= "0000000000001111000";
        elsif std_match(input, "1-10-0--") then next_state <= s101100; output <= "0000010000000000000";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0100001010010010111";
        elsif std_match(input, "0-10-0--") then next_state <= s000000; output <= "0000010000000000000";
        elsif std_match(input, "0-11-0--") then next_state <= s000000; output <= "0000011000011011001";
        elsif std_match(input, "0-00-0--") then next_state <= s000000; output <= "0000000000001111000";
        elsif std_match(input, "0-01-0--") then next_state <= s000000; output <= "0000010001001101000";
        end if;
      when s111100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001110001010000";
        elsif std_match(input, "1-------") then next_state <= s100011; output <= "0000001110001010000";
        end if;
      when s101100 =>
        if std_match(input, "1-------") then next_state <= s010110; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s010111 =>
        if std_match(input, "1----0--") then next_state <= s001100; output <= "0000000000110010010";
        elsif std_match(input, "1----1--") then next_state <= s001100; output <= "0000000000110010110";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000000000110010010";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000000000110010110";
        end if;
      when s001100 =>
        if std_match(input, "1----0--") then next_state <= s010001; output <= "0000001010001010000";
        elsif std_match(input, "1----1--") then next_state <= s011011; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s010001 =>
        if std_match(input, "0----0--") then next_state <= s000000; output <= "0000001000011110011";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001000011110111";
        elsif std_match(input, "1----1--") then next_state <= s110110; output <= "0000001000011110111";
        elsif std_match(input, "1----0--") then next_state <= s110110; output <= "0000001000011110011";
        end if;
      when s110110 =>
        if std_match(input, "1-------") then next_state <= s011111; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s011111 =>
        if std_match(input, "0----11-") then next_state <= s000000; output <= "0000000000110111111";
        elsif std_match(input, "0----10-") then next_state <= s000000; output <= "0000000000110111110";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000000000110111010";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000000000110111011";
        elsif std_match(input, "1----00-") then next_state <= s101110; output <= "0000000000110111010";
        elsif std_match(input, "1----01-") then next_state <= s101110; output <= "0000000000110111011";
        elsif std_match(input, "1----10-") then next_state <= s101110; output <= "0000000000110111110";
        elsif std_match(input, "1----11-") then next_state <= s101110; output <= "0000000000110111111";
        end if;
      when s101110 =>
        if std_match(input, "1-------") then next_state <= s010101; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s010101 =>
        if std_match(input, "1----1--") then next_state <= s111110; output <= "0000001000001111101";
        elsif std_match(input, "1----0--") then next_state <= s111110; output <= "0000001000001111001";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000001000001111001";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001000001111101";
        end if;
      when s111110 =>
        if std_match(input, "00--1-0-") then next_state <= s000000; output <= "1000001010001010000";
        elsif std_match(input, "01--1-0-") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "0---0-0-") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "0---0-1-") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "0---1-1-") then next_state <= s000000; output <= "1000001010001010000";
        elsif std_match(input, "10--0---") then next_state <= s000011; output <= "0000001010001010000";
        elsif std_match(input, "10--1--1") then next_state <= s111010; output <= "1000001010001010000";
        elsif std_match(input, "10--1--0") then next_state <= s011010; output <= "1000001010001010000";
        elsif std_match(input, "11--1-11") then next_state <= s111010; output <= "1000001010001010000";
        elsif std_match(input, "11--0-11") then next_state <= s000011; output <= "0000001010001010000";
        elsif std_match(input, "11--1-10") then next_state <= s011010; output <= "1000001010001010000";
        elsif std_match(input, "11--0-10") then next_state <= s000011; output <= "0000001010001010000";
        elsif std_match(input, "11--1-00") then next_state <= s111011; output <= "0000001010001010000";
        elsif std_match(input, "11--1-01") then next_state <= s000011; output <= "0000001010001010000";
        elsif std_match(input, "11--0-0-") then next_state <= s000011; output <= "0000001010001010000";
        end if;
      when s000011 =>
        if std_match(input, "1----0-1") then next_state <= s001110; output <= "0000001010010010011";
        elsif std_match(input, "1----0-0") then next_state <= s001110; output <= "0000001010010110011";
        elsif std_match(input, "1----1--") then next_state <= s001110; output <= "0000001010010010111";
        elsif std_match(input, "0----0-1") then next_state <= s000000; output <= "0000001010010010011";
        elsif std_match(input, "0----1-1") then next_state <= s000000; output <= "0000001010010010111";
        elsif std_match(input, "0----0-0") then next_state <= s000000; output <= "0000001010010110011";
        elsif std_match(input, "0----1-0") then next_state <= s000000; output <= "0000001010010010111";
        end if;
      when s111010 =>
        if std_match(input, "1-------") then next_state <= s100000; output <= "0000001010010010011";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010010010011";
        end if;
      when s100000 =>
        if std_match(input, "00--1---") then next_state <= s000000; output <= "0000101010001010000";
        elsif std_match(input, "01--1---") then next_state <= s000000; output <= "0000001110001010000";
        elsif std_match(input, "11--1---") then next_state <= s101000; output <= "0000001110001010000";
        elsif std_match(input, "10--1---") then next_state <= s110000; output <= "0000101010001010000";
        elsif std_match(input, "11--0---") then next_state <= s101000; output <= "0000001110001010000";
        elsif std_match(input, "01--0---") then next_state <= s000000; output <= "0000001110001010000";
        elsif std_match(input, "00--0---") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "10--0---") then next_state <= s011110; output <= "0000001010001010000";
        end if;
      when s101000 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001010000110011";
        elsif std_match(input, "1-------") then next_state <= s010010; output <= "0000001010000110011";
        end if;
      when s010010 =>
        if std_match(input, "1---0---") then next_state <= s011110; output <= "0000001010001010000";
        elsif std_match(input, "0---0---") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "0---1---") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1---1---") then next_state <= s001010; output <= "0000001010001010000";
        end if;
      when s011110 =>
        if std_match(input, "0-00-00-") then next_state <= s000000; output <= "0000000000001111000";
        elsif std_match(input, "0-00-01-") then next_state <= s000000; output <= "0000000000001111001";
        elsif std_match(input, "0-10-01-") then next_state <= s000000; output <= "0000010000000000001";
        elsif std_match(input, "0-10-00-") then next_state <= s000000; output <= "0000010000000000000";
        elsif std_match(input, "0--0-1--") then next_state <= s000000; output <= "0000001010010010111";
        elsif std_match(input, "0--1-1--") then next_state <= s000000; output <= "0000001010010010111";
        elsif std_match(input, "0-11-0--") then next_state <= s000000; output <= "0000011000011011001";
        elsif std_match(input, "0-01-00-") then next_state <= s000000; output <= "0000010001001101000";
        elsif std_match(input, "0-01-01-") then next_state <= s000000; output <= "0000010001001101001";
        elsif std_match(input, "1-0--1--") then next_state <= s100000; output <= "0000001010010010111";
        elsif std_match(input, "1-00-00-") then next_state <= s000010; output <= "0000000000001111000";
        elsif std_match(input, "1-00-01-") then next_state <= s000010; output <= "0000000000001111001";
        elsif std_match(input, "1-01-01-") then next_state <= s000010; output <= "0000010001001101001";
        elsif std_match(input, "1-01-00-") then next_state <= s000010; output <= "0000010001001101000";
        elsif std_match(input, "1-10-1--") then next_state <= s100000; output <= "0000001010010010111";
        elsif std_match(input, "1-10-01-") then next_state <= s000010; output <= "0000010000000000001";
        elsif std_match(input, "1-10-00-") then next_state <= s000010; output <= "0000010000000000000";
        elsif std_match(input, "1-11-1--") then next_state <= s100000; output <= "0000001010010010111";
        elsif std_match(input, "1-11-0--") then next_state <= s110011; output <= "0000011000011011001";
        end if;
      when s000010 =>
        if std_match(input, "1----0--") then next_state <= s011110; output <= "0001001010001010000";
        elsif std_match(input, "1----1--") then next_state <= s011110; output <= "0000001010001010000";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0001001010001010000";
        end if;
      when s001010 =>
        if std_match(input, "0----0--") then next_state <= s000000; output <= "0000001010100010001";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001000011011101";
        elsif std_match(input, "1----0--") then next_state <= s111000; output <= "0000001010100010001";
        elsif std_match(input, "1----1--") then next_state <= s100100; output <= "0000001000011011101";
        end if;
      when s111000 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1---01--") then next_state <= s001010; output <= "0000001010001010000";
        elsif std_match(input, "1---00--") then next_state <= s001000; output <= "0000001010001010000";
        elsif std_match(input, "1---1---") then next_state <= s001000; output <= "0000001010001010000";
        end if;
      when s001000 =>
        if std_match(input, "1----0--") then next_state <= s100100; output <= "0000001000011011001";
        elsif std_match(input, "1----1--") then next_state <= s100100; output <= "0000001000011011101";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000001000011011001";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001000011011101";
        end if;
      when s100100 =>
        if std_match(input, "1-------") then next_state <= s001011; output <= "0001001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0001001010001010000";
        end if;
      when s001011 =>
        if std_match(input, "1----0--") then next_state <= s110100; output <= "0000001000011011010";
        elsif std_match(input, "1----1--") then next_state <= s110100; output <= "0000001000011011110";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000001000011011010";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001000011011110";
        end if;
      when s110100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0001001010001010000";
        elsif std_match(input, "1-------") then next_state <= s011011; output <= "0001001010001010000";
        end if;
      when s011011 =>
        if std_match(input, "0----10-") then next_state <= s000000; output <= "0000001000011010111";
        elsif std_match(input, "0----11-") then next_state <= s000000; output <= "0000001000011010110";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000001000011010010";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000001000011010011";
        elsif std_match(input, "1----01-") then next_state <= s100110; output <= "0000001000011010010";
        elsif std_match(input, "1----00-") then next_state <= s100110; output <= "0000001000011010011";
        elsif std_match(input, "1----11-") then next_state <= s100110; output <= "0000001000011010110";
        elsif std_match(input, "1----10-") then next_state <= s100110; output <= "0000001000011010111";
        end if;
      when s100110 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1-------") then next_state <= s011101; output <= "0000001010001010000";
        end if;
      when s011101 =>
        if std_match(input, "0----00-") then next_state <= s000000; output <= "0000000000110011000";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000000000110011001";
        elsif std_match(input, "0----11-") then next_state <= s000000; output <= "0000000000110011101";
        elsif std_match(input, "0----10-") then next_state <= s000000; output <= "0000000000110011100";
        elsif std_match(input, "1----11-") then next_state <= s101110; output <= "0000000000110011101";
        elsif std_match(input, "1----10-") then next_state <= s101110; output <= "0000000000110011100";
        elsif std_match(input, "1----00-") then next_state <= s101110; output <= "0000000000110011000";
        elsif std_match(input, "1----01-") then next_state <= s101110; output <= "0000000000110011001";
        end if;
      when s110000 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001000001111001";
        elsif std_match(input, "1-------") then next_state <= s000110; output <= "0000001000001111001";
        end if;
      when s000110 =>
        if std_match(input, "0----0--") then next_state <= s000000; output <= "0001001010001010000";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0100001010001010000";
        elsif std_match(input, "1---01--") then next_state <= s011000; output <= "0100001010001010000";
        elsif std_match(input, "1---00--") then next_state <= s011000; output <= "0001001010001010000";
        elsif std_match(input, "1---11--") then next_state <= s011110; output <= "0100001010001010000";
        elsif std_match(input, "1---10--") then next_state <= s011110; output <= "0001001010001010000";
        end if;
      when s011010 =>
        if std_match(input, "1----1--") then next_state <= s100000; output <= "0000001010010010111";
        elsif std_match(input, "1----00-") then next_state <= s110010; output <= "0000001010100010001";
        elsif std_match(input, "1----01-") then next_state <= s110010; output <= "0000001010100010000";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000001010100010001";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000001010100010000";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000001010010010111";
        end if;
      when s110010 =>
        if std_match(input, "1----00-") then next_state <= s011100; output <= "0000001010001010000";
        elsif std_match(input, "1----01-") then next_state <= s011010; output <= "0000001010001010000";
        elsif std_match(input, "1----10-") then next_state <= s011010; output <= "0000001010001010000";
        elsif std_match(input, "1----11-") then next_state <= s011100; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s011100 =>
        if std_match(input, "0----11-") then next_state <= s000000; output <= "0000001000111010111";
        elsif std_match(input, "0----10-") then next_state <= s000000; output <= "0000001000111010110";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000001000111010011";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000001000111010010";
        elsif std_match(input, "1----10-") then next_state <= s101010; output <= "0000001000111010110";
        elsif std_match(input, "1----11-") then next_state <= s101010; output <= "0000001000111010111";
        elsif std_match(input, "1----01-") then next_state <= s100010; output <= "0000001000111010011";
        elsif std_match(input, "1----00-") then next_state <= s100010; output <= "0000001000111010010";
        end if;
      when s101010 =>
        if std_match(input, "1-------") then next_state <= s111010; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s100010 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        elsif std_match(input, "1-------") then next_state <= s011010; output <= "0000001010001010000";
        end if;
      when s111011 =>
        if std_match(input, "1----0--") then next_state <= s100111; output <= "0000001010010110011";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000001010010110011";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0010101010010010111";
        elsif std_match(input, "1----1--") then next_state <= s010000; output <= "0010101010010010111";
        end if;
      when s100111 =>
        if std_match(input, "1-------") then next_state <= s111011; output <= "0000001010001010000";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000001010001010000";
        end if;
      when s010000 =>
        if std_match(input, "--------") then next_state <= s000000; output <= "0000001000011010010";
        end if;
      when others => next_state <= "------"; output <= "-------------------";
    end case;
  end process;
end behaviour;
