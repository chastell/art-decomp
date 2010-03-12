library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s1494_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(7 downto 0);
    output: out std_logic_vector(18 downto 0)
  );
end s1494_jed;
architecture behaviour of s1494_jed is
  constant s000000: std_logic_vector(5 downto 0) := "000000";
  constant s001110: std_logic_vector(5 downto 0) := "000001";
  constant s011000: std_logic_vector(5 downto 0) := "111000";
  constant s010000: std_logic_vector(5 downto 0) := "101001";
  constant s010100: std_logic_vector(5 downto 0) := "100000";
  constant s110011: std_logic_vector(5 downto 0) := "010000";
  constant s010011: std_logic_vector(5 downto 0) := "101110";
  constant s000100: std_logic_vector(5 downto 0) := "011000";
  constant s010111: std_logic_vector(5 downto 0) := "100010";
  constant s010110: std_logic_vector(5 downto 0) := "100011";
  constant s100011: std_logic_vector(5 downto 0) := "100110";
  constant s001100: std_logic_vector(5 downto 0) := "110010";
  constant s011011: std_logic_vector(5 downto 0) := "101100";
  constant s010001: std_logic_vector(5 downto 0) := "001110";
  constant s100110: std_logic_vector(5 downto 0) := "000100";
  constant s011101: std_logic_vector(5 downto 0) := "111010";
  constant s101110: std_logic_vector(5 downto 0) := "001000";
  constant s010101: std_logic_vector(5 downto 0) := "010110";
  constant s111110: std_logic_vector(5 downto 0) := "000101";
  constant s000011: std_logic_vector(5 downto 0) := "100100";
  constant s111011: std_logic_vector(5 downto 0) := "100101";
  constant s011010: std_logic_vector(5 downto 0) := "101000";
  constant s111010: std_logic_vector(5 downto 0) := "100001";
  constant s100111: std_logic_vector(5 downto 0) := "001011";
  constant s110010: std_logic_vector(5 downto 0) := "001010";
  constant s100000: std_logic_vector(5 downto 0) := "000011";
  constant s011100: std_logic_vector(5 downto 0) := "101010";
  constant s101010: std_logic_vector(5 downto 0) := "001100";
  constant s100010: std_logic_vector(5 downto 0) := "000110";
  constant s101000: std_logic_vector(5 downto 0) := "110011";
  constant s011110: std_logic_vector(5 downto 0) := "110000";
  constant s110000: std_logic_vector(5 downto 0) := "111001";
  constant s010010: std_logic_vector(5 downto 0) := "001101";
  constant s001010: std_logic_vector(5 downto 0) := "110001";
  constant s100100: std_logic_vector(5 downto 0) := "001001";
  constant s111000: std_logic_vector(5 downto 0) := "011001";
  constant s001011: std_logic_vector(5 downto 0) := "110110";
  constant s110100: std_logic_vector(5 downto 0) := "010100";
  constant s001000: std_logic_vector(5 downto 0) := "010001";
  constant s000010: std_logic_vector(5 downto 0) := "000010";
  constant s000111: std_logic_vector(5 downto 0) := "101101";
  constant s101011: std_logic_vector(5 downto 0) := "011010";
  constant s001111: std_logic_vector(5 downto 0) := "011100";
  constant s000110: std_logic_vector(5 downto 0) := "101011";
  constant s110110: std_logic_vector(5 downto 0) := "110100";
  constant s011111: std_logic_vector(5 downto 0) := "111100";
  constant s111100: std_logic_vector(5 downto 0) := "010011";
  constant s101100: std_logic_vector(5 downto 0) := "010010";
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
        if std_match(input, "0-01----") then next_state <= s000000; output <= "1000000001000000001";
        elsif std_match(input, "0-00----") then next_state <= s000000; output <= "1000000000100000001";
        elsif std_match(input, "0-10----") then next_state <= s000000; output <= "0000000000000000000";
        elsif std_match(input, "0-11----") then next_state <= s000000; output <= "0001001100111110001";
        elsif std_match(input, "1-01----") then next_state <= s000000; output <= "1000000001000000001";
        elsif std_match(input, "1-00----") then next_state <= s000000; output <= "1000000000100000001";
        elsif std_match(input, "1-11----") then next_state <= s001110; output <= "0001001100111110001";
        elsif std_match(input, "1-10----") then next_state <= s000000; output <= "0000000000000000000";
        end if;
      when s001110 =>
        if std_match(input, "1---0---") then next_state <= s011000; output <= "0000000000100100101";
        elsif std_match(input, "11--1---") then next_state <= s010000; output <= "1000010010100000101";
        elsif std_match(input, "10--1---") then next_state <= s011000; output <= "0000000000100100101";
        elsif std_match(input, "00------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "01--1---") then next_state <= s000000; output <= "1000010010100000101";
        elsif std_match(input, "01--0---") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s011000 =>
        if std_match(input, "0-00-000") then next_state <= s000000; output <= "1000000000110000110";
        elsif std_match(input, "0-00-010") then next_state <= s000000; output <= "1000000000100000110";
        elsif std_match(input, "0-00-110") then next_state <= s000000; output <= "1000000100100000110";
        elsif std_match(input, "0-00-100") then next_state <= s000000; output <= "1000000100110000110";
        elsif std_match(input, "0-01-100") then next_state <= s000000; output <= "1000001101010000110";
        elsif std_match(input, "0-01-110") then next_state <= s000000; output <= "1000001101000000110";
        elsif std_match(input, "0-01-010") then next_state <= s000000; output <= "1000001001000000110";
        elsif std_match(input, "0-01-000") then next_state <= s000000; output <= "1000001001010000110";
        elsif std_match(input, "0-0---01") then next_state <= s000000; output <= "0100000000111111100";
        elsif std_match(input, "0-0---11") then next_state <= s000000; output <= "0100000000101111100";
        elsif std_match(input, "0-10-000") then next_state <= s000000; output <= "0000001000010000000";
        elsif std_match(input, "0-10-010") then next_state <= s000000; output <= "0000001000000000000";
        elsif std_match(input, "0-11-0-0") then next_state <= s000000; output <= "0000001000110110110";
        elsif std_match(input, "0-10-110") then next_state <= s000000; output <= "0000001100000000000";
        elsif std_match(input, "0-10-100") then next_state <= s000000; output <= "0000001100010000000";
        elsif std_match(input, "0-11-1-0") then next_state <= s000000; output <= "0000001100110110110";
        elsif std_match(input, "0-1---01") then next_state <= s000000; output <= "0100000000111111100";
        elsif std_match(input, "0-1---11") then next_state <= s000000; output <= "0100000000101111100";
        elsif std_match(input, "1--1--01") then next_state <= s010100; output <= "0100000000111111100";
        elsif std_match(input, "1--1--11") then next_state <= s010100; output <= "0100000000101111100";
        elsif std_match(input, "1-11-0-0") then next_state <= s110011; output <= "0000001000110110110";
        elsif std_match(input, "1-11-1-0") then next_state <= s110011; output <= "0000001100110110110";
        elsif std_match(input, "1-01-110") then next_state <= s010100; output <= "1000001101000000110";
        elsif std_match(input, "1-01-100") then next_state <= s010100; output <= "1000001101010000110";
        elsif std_match(input, "1-01-010") then next_state <= s010100; output <= "1000001001000000110";
        elsif std_match(input, "1-01-000") then next_state <= s010100; output <= "1000001001010000110";
        elsif std_match(input, "1--0--11") then next_state <= s010100; output <= "0100000000101111100";
        elsif std_match(input, "1--0--01") then next_state <= s010100; output <= "0100000000111111100";
        elsif std_match(input, "1-10-100") then next_state <= s010100; output <= "0000001100010000000";
        elsif std_match(input, "1-10-110") then next_state <= s010100; output <= "0000001100000000000";
        elsif std_match(input, "1-10-000") then next_state <= s010100; output <= "0000001000010000000";
        elsif std_match(input, "1-10-010") then next_state <= s010100; output <= "0000001000000000000";
        elsif std_match(input, "1-00-110") then next_state <= s010100; output <= "1000000100100000110";
        elsif std_match(input, "1-00-100") then next_state <= s010100; output <= "1000000100110000110";
        elsif std_match(input, "1-00-000") then next_state <= s010100; output <= "1000000000110000110";
        elsif std_match(input, "1-00-010") then next_state <= s010100; output <= "1000000000100000110";
        end if;
      when s010100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1-------") then next_state <= s010011; output <= "0000000000100100101";
        end if;
      when s010011 =>
        if std_match(input, "0----0--") then next_state <= s000000; output <= "1000000000111100001";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "1000000100111100001";
        elsif std_match(input, "1----1--") then next_state <= s000100; output <= "1000000100111100001";
        elsif std_match(input, "1----0--") then next_state <= s000100; output <= "1000000000111100001";
        end if;
      when s000100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "10---11-") then next_state <= s010111; output <= "0000000000100100101";
        elsif std_match(input, "11--011-") then next_state <= s010111; output <= "0000000000100100101";
        elsif std_match(input, "11--111-") then next_state <= s010110; output <= "0000000000100100101";
        elsif std_match(input, "11---01-") then next_state <= s100011; output <= "0000000000100100101";
        elsif std_match(input, "10---01-") then next_state <= s010111; output <= "0000000000100100101";
        elsif std_match(input, "1-----0-") then next_state <= s010111; output <= "0000000000100100101";
        end if;
      when s010111 =>
        if std_match(input, "0----1--") then next_state <= s000000; output <= "0000000100101011000";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000000000101011000";
        elsif std_match(input, "1----0--") then next_state <= s001100; output <= "0000000000101011000";
        elsif std_match(input, "1----1--") then next_state <= s001100; output <= "0000000100101011000";
        end if;
      when s001100 =>
        if std_match(input, "1----1--") then next_state <= s011011; output <= "0000000000100100101";
        elsif std_match(input, "1----0--") then next_state <= s010001; output <= "0000000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s011011 =>
        if std_match(input, "0----11-") then next_state <= s000000; output <= "0000000100101110100";
        elsif std_match(input, "0----10-") then next_state <= s000000; output <= "0000000100111110100";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000000000101110100";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000000000111110100";
        elsif std_match(input, "1----11-") then next_state <= s100110; output <= "0000000100101110100";
        elsif std_match(input, "1----10-") then next_state <= s100110; output <= "0000000100111110100";
        elsif std_match(input, "1----01-") then next_state <= s100110; output <= "0000000000101110100";
        elsif std_match(input, "1----00-") then next_state <= s100110; output <= "0000000000111110100";
        end if;
      when s100110 =>
        if std_match(input, "1-------") then next_state <= s011101; output <= "0000000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s011101 =>
        if std_match(input, "0----01-") then next_state <= s000000; output <= "0000000000110011010";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000000000100011010";
        elsif std_match(input, "0----10-") then next_state <= s000000; output <= "0000000100100011010";
        elsif std_match(input, "0----11-") then next_state <= s000000; output <= "0000000100110011010";
        elsif std_match(input, "1----11-") then next_state <= s101110; output <= "0000000100110011010";
        elsif std_match(input, "1----10-") then next_state <= s101110; output <= "0000000100100011010";
        elsif std_match(input, "1----01-") then next_state <= s101110; output <= "0000000000110011010";
        elsif std_match(input, "1----00-") then next_state <= s101110; output <= "0000000000100011010";
        end if;
      when s101110 =>
        if std_match(input, "1-------") then next_state <= s010101; output <= "0000000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s010101 =>
        if std_match(input, "1----0--") then next_state <= s111110; output <= "1000000000110100110";
        elsif std_match(input, "1----1--") then next_state <= s111110; output <= "1000000100110100110";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "1000000000110100110";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "1000000100110100110";
        end if;
      when s111110 =>
        if std_match(input, "01----0-") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "00--1-0-") then next_state <= s000000; output <= "0000100000100100101";
        elsif std_match(input, "00--0-0-") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "11----01") then next_state <= s000011; output <= "0000000000100100101";
        elsif std_match(input, "11--0-00") then next_state <= s000011; output <= "0000000000100100101";
        elsif std_match(input, "11--1-00") then next_state <= s111011; output <= "0000000000100100101";
        elsif std_match(input, "10--0-0-") then next_state <= s000011; output <= "0000000000100100101";
        elsif std_match(input, "10--1-00") then next_state <= s011010; output <= "0000100000100100101";
        elsif std_match(input, "10--1-01") then next_state <= s111010; output <= "0000100000100100101";
        elsif std_match(input, "0---1-1-") then next_state <= s000000; output <= "0000100000100100101";
        elsif std_match(input, "0---0-1-") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1---0-1-") then next_state <= s000011; output <= "0000000000100100101";
        elsif std_match(input, "1---1-10") then next_state <= s011010; output <= "0000100000100100101";
        elsif std_match(input, "1---1-11") then next_state <= s111010; output <= "0000100000100100101";
        end if;
      when s000011 =>
        if std_match(input, "0----0-1") then next_state <= s000000; output <= "0000000000111110001";
        elsif std_match(input, "0----1-1") then next_state <= s000000; output <= "0000000100111110001";
        elsif std_match(input, "0----0-0") then next_state <= s000000; output <= "1000000000111110001";
        elsif std_match(input, "0----1-0") then next_state <= s000000; output <= "0000000100111110001";
        elsif std_match(input, "1----0-1") then next_state <= s001110; output <= "0000000000111110001";
        elsif std_match(input, "1----1-1") then next_state <= s001110; output <= "0000000100111110001";
        elsif std_match(input, "1----0-0") then next_state <= s001110; output <= "1000000000111110001";
        elsif std_match(input, "1----1-0") then next_state <= s001110; output <= "0000000100111110001";
        end if;
      when s111011 =>
        if std_match(input, "1----0--") then next_state <= s100111; output <= "1000000000111110001";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "1000000000111110001";
        elsif std_match(input, "1----1--") then next_state <= s010000; output <= "0000010110111110001";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000010110111110001";
        end if;
      when s100111 =>
        if std_match(input, "1-------") then next_state <= s111011; output <= "0000000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s010000 =>
        if std_match(input, "--------") then next_state <= s000000; output <= "0000000000101110100";
        end if;
      when s011010 =>
        if std_match(input, "1----01-") then next_state <= s110010; output <= "0000000000100101001";
        elsif std_match(input, "1----00-") then next_state <= s110010; output <= "0000000000110101001";
        elsif std_match(input, "1----1--") then next_state <= s100000; output <= "0000000100111110001";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000000000100101001";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000000000110101001";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000000100111110001";
        end if;
      when s110010 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1----00-") then next_state <= s011100; output <= "0000000000100100101";
        elsif std_match(input, "1----01-") then next_state <= s011010; output <= "0000000000100100101";
        elsif std_match(input, "1----11-") then next_state <= s011100; output <= "0000000000100100101";
        elsif std_match(input, "1----10-") then next_state <= s011010; output <= "0000000000100100101";
        end if;
      when s011100 =>
        if std_match(input, "1----10-") then next_state <= s101010; output <= "0000000100101111100";
        elsif std_match(input, "1----11-") then next_state <= s101010; output <= "0000000100111111100";
        elsif std_match(input, "1----00-") then next_state <= s100010; output <= "0000000000101111100";
        elsif std_match(input, "1----01-") then next_state <= s100010; output <= "0000000000111111100";
        elsif std_match(input, "0----10-") then next_state <= s000000; output <= "0000000100101111100";
        elsif std_match(input, "0----11-") then next_state <= s000000; output <= "0000000100111111100";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "0000000000101111100";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "0000000000111111100";
        end if;
      when s101010 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1-------") then next_state <= s111010; output <= "0000000000100100101";
        end if;
      when s111010 =>
        if std_match(input, "1-------") then next_state <= s100000; output <= "0000000000111110001";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000111110001";
        end if;
      when s100000 =>
        if std_match(input, "11------") then next_state <= s101000; output <= "0100000000100100101";
        elsif std_match(input, "01------") then next_state <= s000000; output <= "0100000000100100101";
        elsif std_match(input, "00--0---") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "00--1---") then next_state <= s000000; output <= "0000010000100100101";
        elsif std_match(input, "10--0---") then next_state <= s011110; output <= "0000000000100100101";
        elsif std_match(input, "10--1---") then next_state <= s110000; output <= "0000010000100100101";
        end if;
      when s101000 =>
        if std_match(input, "1-------") then next_state <= s010010; output <= "1000000000111100001";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "1000000000111100001";
        end if;
      when s010010 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1---1---") then next_state <= s001010; output <= "0000000000100100101";
        elsif std_match(input, "1---0---") then next_state <= s011110; output <= "0000000000100100101";
        end if;
      when s001010 =>
        if std_match(input, "1----1--") then next_state <= s100100; output <= "0000000100110110110";
        elsif std_match(input, "1----0--") then next_state <= s111000; output <= "0000000000110101001";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000000100110110110";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000000000110101001";
        end if;
      when s100100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0010000000100100101";
        elsif std_match(input, "1-------") then next_state <= s001011; output <= "0010000000100100101";
        end if;
      when s001011 =>
        if std_match(input, "0----0--") then next_state <= s000000; output <= "0000000000101110110";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000000100101110110";
        elsif std_match(input, "1----0--") then next_state <= s110100; output <= "0000000000101110110";
        elsif std_match(input, "1----1--") then next_state <= s110100; output <= "0000000100101110110";
        end if;
      when s110100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0010000000100100101";
        elsif std_match(input, "1-------") then next_state <= s011011; output <= "0010000000100100101";
        end if;
      when s111000 =>
        if std_match(input, "1----0--") then next_state <= s001000; output <= "0000000000100100101";
        elsif std_match(input, "1---11--") then next_state <= s001000; output <= "0000000000100100101";
        elsif std_match(input, "1---01--") then next_state <= s001010; output <= "0000000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s001000 =>
        if std_match(input, "1----1--") then next_state <= s100100; output <= "0000000100110110110";
        elsif std_match(input, "1----0--") then next_state <= s100100; output <= "0000000000110110110";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000000000110110110";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000000100110110110";
        end if;
      when s011110 =>
        if std_match(input, "0----1--") then next_state <= s000000; output <= "0000000100111110001";
        elsif std_match(input, "0-11-0--") then next_state <= s000000; output <= "0000001000110110110";
        elsif std_match(input, "0-10-00-") then next_state <= s000000; output <= "0000001000000000000";
        elsif std_match(input, "0-10-01-") then next_state <= s000000; output <= "0000001000010000000";
        elsif std_match(input, "0-00-00-") then next_state <= s000000; output <= "1000000000100000110";
        elsif std_match(input, "0-00-01-") then next_state <= s000000; output <= "1000000000110000110";
        elsif std_match(input, "0-01-01-") then next_state <= s000000; output <= "1000001001010000110";
        elsif std_match(input, "0-01-00-") then next_state <= s000000; output <= "1000001001000000110";
        elsif std_match(input, "1----1--") then next_state <= s100000; output <= "0000000100111110001";
        elsif std_match(input, "1-00-00-") then next_state <= s000010; output <= "1000000000100000110";
        elsif std_match(input, "1-00-01-") then next_state <= s000010; output <= "1000000000110000110";
        elsif std_match(input, "1-01-01-") then next_state <= s000010; output <= "1000001001010000110";
        elsif std_match(input, "1-01-00-") then next_state <= s000010; output <= "1000001001000000110";
        elsif std_match(input, "1-11-0--") then next_state <= s110011; output <= "0000001000110110110";
        elsif std_match(input, "1-10-00-") then next_state <= s000010; output <= "0000001000000000000";
        elsif std_match(input, "1-10-01-") then next_state <= s000010; output <= "0000001000010000000";
        end if;
      when s000010 =>
        if std_match(input, "1----0--") then next_state <= s011110; output <= "0010000000100100101";
        elsif std_match(input, "1----1--") then next_state <= s011110; output <= "0000000000100100101";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0010000000100100101";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s110011 =>
        if std_match(input, "1-------") then next_state <= s000111; output <= "0000000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s000111 =>
        if std_match(input, "0----1--") then next_state <= s000000; output <= "0000000100101110110";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0000000000101110110";
        elsif std_match(input, "1----1--") then next_state <= s101011; output <= "0000000100101110110";
        elsif std_match(input, "1----0--") then next_state <= s101011; output <= "0000000000101110110";
        end if;
      when s101011 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1-------") then next_state <= s001111; output <= "0000000000100100101";
        end if;
      when s001111 =>
        if std_match(input, "1----1--") then next_state <= s000100; output <= "0010000100111001110";
        elsif std_match(input, "1----0--") then next_state <= s000100; output <= "0010000000111001110";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0010000100111001110";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0010000000111001110";
        end if;
      when s110000 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "1000000000110100110";
        elsif std_match(input, "1-------") then next_state <= s000110; output <= "1000000000110100110";
        end if;
      when s000110 =>
        if std_match(input, "1---01--") then next_state <= s011000; output <= "0001000000100100101";
        elsif std_match(input, "1---00--") then next_state <= s011000; output <= "0010000000100100101";
        elsif std_match(input, "1---10--") then next_state <= s011110; output <= "0010000000100100101";
        elsif std_match(input, "1---11--") then next_state <= s011110; output <= "0001000000100100101";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "0010000000100100101";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "0001000000100100101";
        end if;
      when s100010 =>
        if std_match(input, "1-------") then next_state <= s011010; output <= "0000000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        end if;
      when s010001 =>
        if std_match(input, "1----0--") then next_state <= s110110; output <= "1000000000111110100";
        elsif std_match(input, "1----1--") then next_state <= s110110; output <= "1000000100111110100";
        elsif std_match(input, "0----1--") then next_state <= s000000; output <= "1000000100111110100";
        elsif std_match(input, "0----0--") then next_state <= s000000; output <= "1000000000111110100";
        end if;
      when s110110 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1-------") then next_state <= s011111; output <= "0000000000100100101";
        end if;
      when s011111 =>
        if std_match(input, "0----11-") then next_state <= s000000; output <= "1000000100111011010";
        elsif std_match(input, "0----10-") then next_state <= s000000; output <= "1000000100101011010";
        elsif std_match(input, "0----00-") then next_state <= s000000; output <= "1000000000101011010";
        elsif std_match(input, "0----01-") then next_state <= s000000; output <= "1000000000111011010";
        elsif std_match(input, "1----10-") then next_state <= s101110; output <= "1000000100101011010";
        elsif std_match(input, "1----11-") then next_state <= s101110; output <= "1000000100111011010";
        elsif std_match(input, "1----00-") then next_state <= s101110; output <= "1000000000101011010";
        elsif std_match(input, "1----01-") then next_state <= s101110; output <= "1000000000111011010";
        end if;
      when s010110 =>
        if std_match(input, "1----1--") then next_state <= s111100; output <= "0001000100111110001";
        elsif std_match(input, "1-00-0--") then next_state <= s101100; output <= "1000000000100000110";
        elsif std_match(input, "1-01-0--") then next_state <= s101100; output <= "1000001001000000110";
        elsif std_match(input, "1-10-0--") then next_state <= s101100; output <= "0000001000000000000";
        elsif std_match(input, "1-11-0--") then next_state <= s110011; output <= "0000001000110110110";
        elsif std_match(input, "0-00-0--") then next_state <= s000000; output <= "1000000000100000110";
        elsif std_match(input, "0-01-0--") then next_state <= s000000; output <= "1000001001000000110";
        elsif std_match(input, "0-0--1--") then next_state <= s000000; output <= "0001000100111110001";
        elsif std_match(input, "0-1--1--") then next_state <= s000000; output <= "0001000100111110001";
        elsif std_match(input, "0-10-0--") then next_state <= s000000; output <= "0000001000000000000";
        elsif std_match(input, "0-11-0--") then next_state <= s000000; output <= "0000001000110110110";
        end if;
      when s111100 =>
        if std_match(input, "1-------") then next_state <= s100011; output <= "0100000000100100101";
        elsif std_match(input, "0-------") then next_state <= s000000; output <= "0100000000100100101";
        end if;
      when s100011 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000110110110";
        elsif std_match(input, "1-------") then next_state <= s110011; output <= "0000000000110110110";
        end if;
      when s101100 =>
        if std_match(input, "0-------") then next_state <= s000000; output <= "0000000000100100101";
        elsif std_match(input, "1-------") then next_state <= s010110; output <= "0000000000100100101";
        end if;
      when others => next_state <= "------"; output <= "-------------------";
    end case;
  end process;
end behaviour;
