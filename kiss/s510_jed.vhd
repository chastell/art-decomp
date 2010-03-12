library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s510_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(18 downto 0);
    output: out std_logic_vector(6 downto 0)
  );
end s510_jed;
architecture behaviour of s510_jed is
  constant s000000: std_logic_vector(5 downto 0) := "011011";
  constant s010010: std_logic_vector(5 downto 0) := "111010";
  constant s010011: std_logic_vector(5 downto 0) := "110010";
  constant s000100: std_logic_vector(5 downto 0) := "110011";
  constant s000001: std_logic_vector(5 downto 0) := "111011";
  constant s100101: std_logic_vector(5 downto 0) := "111100";
  constant s100100: std_logic_vector(5 downto 0) := "111110";
  constant s000010: std_logic_vector(5 downto 0) := "111101";
  constant s000011: std_logic_vector(5 downto 0) := "111111";
  constant s011100: std_logic_vector(5 downto 0) := "101000";
  constant s011101: std_logic_vector(5 downto 0) := "100000";
  constant s000111: std_logic_vector(5 downto 0) := "110110";
  constant s000101: std_logic_vector(5 downto 0) := "110111";
  constant s010000: std_logic_vector(5 downto 0) := "101110";
  constant s010001: std_logic_vector(5 downto 0) := "101010";
  constant s001000: std_logic_vector(5 downto 0) := "010110";
  constant s001001: std_logic_vector(5 downto 0) := "000110";
  constant s010100: std_logic_vector(5 downto 0) := "000010";
  constant s010101: std_logic_vector(5 downto 0) := "000000";
  constant s001010: std_logic_vector(5 downto 0) := "100110";
  constant s001011: std_logic_vector(5 downto 0) := "100010";
  constant s011000: std_logic_vector(5 downto 0) := "100011";
  constant s011001: std_logic_vector(5 downto 0) := "100001";
  constant s011010: std_logic_vector(5 downto 0) := "010000";
  constant s011011: std_logic_vector(5 downto 0) := "010001";
  constant s001100: std_logic_vector(5 downto 0) := "010101";
  constant s001101: std_logic_vector(5 downto 0) := "010100";
  constant s011110: std_logic_vector(5 downto 0) := "101100";
  constant s011111: std_logic_vector(5 downto 0) := "100100";
  constant s100000: std_logic_vector(5 downto 0) := "001010";
  constant s100001: std_logic_vector(5 downto 0) := "001000";
  constant s100010: std_logic_vector(5 downto 0) := "101101";
  constant s100011: std_logic_vector(5 downto 0) := "101111";
  constant s001110: std_logic_vector(5 downto 0) := "011100";
  constant s001111: std_logic_vector(5 downto 0) := "011101";
  constant s100110: std_logic_vector(5 downto 0) := "010111";
  constant s100111: std_logic_vector(5 downto 0) := "000111";
  constant s101000: std_logic_vector(5 downto 0) := "000011";
  constant s101001: std_logic_vector(5 downto 0) := "001011";
  constant s101010: std_logic_vector(5 downto 0) := "100101";
  constant s101011: std_logic_vector(5 downto 0) := "100111";
  constant s101100: std_logic_vector(5 downto 0) := "001100";
  constant s101101: std_logic_vector(5 downto 0) := "001101";
  constant s101110: std_logic_vector(5 downto 0) := "101001";
  constant s010110: std_logic_vector(5 downto 0) := "000100";
  constant s010111: std_logic_vector(5 downto 0) := "000101";
  constant s000110: std_logic_vector(5 downto 0) := "011010";
  signal current_state, next_state: std_logic_vector(5 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "------"; output <= "-------";
    case current_state is
      when s000000 =>
        if std_match(input, "-------------------") then next_state <= s010010; output <= "0011100";
        end if;
      when s010010 =>
        if std_match(input, "--1----------------") then next_state <= s010011; output <= "0000100";
        elsif std_match(input, "--0----------------") then next_state <= s010010; output <= "0000100";
        end if;
      when s010011 =>
        if std_match(input, "-------------------") then next_state <= s000100; output <= "0001101";
        end if;
      when s000100 =>
        if std_match(input, "---11--------------") then next_state <= s000001; output <= "0000101";
        elsif std_match(input, "---10--------------") then next_state <= s000000; output <= "0000101";
        elsif std_match(input, "---0---------------") then next_state <= s000100; output <= "0000101";
        end if;
      when s000001 =>
        if std_match(input, "-------------------") then next_state <= s100101; output <= "0011000";
        end if;
      when s100101 =>
        if std_match(input, "-----1-------------") then next_state <= s100100; output <= "0000000";
        elsif std_match(input, "-----0-------------") then next_state <= s100101; output <= "0000000";
        end if;
      when s100100 =>
        if std_match(input, "-------------------") then next_state <= s000010; output <= "0001001";
        end if;
      when s000010 =>
        if std_match(input, "------0------------") then next_state <= s000010; output <= "0000001";
        elsif std_match(input, "------10-----------") then next_state <= s000001; output <= "0000001";
        elsif std_match(input, "------11-----------") then next_state <= s000011; output <= "0000001";
        end if;
      when s000011 =>
        if std_match(input, "-------------------") then next_state <= s011100; output <= "0011100";
        end if;
      when s011100 =>
        if std_match(input, "--1----------------") then next_state <= s011101; output <= "0000100";
        elsif std_match(input, "--0----------------") then next_state <= s011100; output <= "0000100";
        end if;
      when s011101 =>
        if std_match(input, "-------------------") then next_state <= s000111; output <= "0001101";
        end if;
      when s000111 =>
        if std_match(input, "---0---------------") then next_state <= s000111; output <= "0000101";
        elsif std_match(input, "---1----0----------") then next_state <= s000011; output <= "0000101";
        elsif std_match(input, "---1----1----------") then next_state <= s000101; output <= "0000101";
        end if;
      when s000101 =>
        if std_match(input, "-------------------") then next_state <= s010000; output <= "0001100";
        end if;
      when s010000 =>
        if std_match(input, "--1----------------") then next_state <= s010001; output <= "0000100";
        elsif std_match(input, "--0----------------") then next_state <= s010000; output <= "0000100";
        end if;
      when s010001 =>
        if std_match(input, "-------------------") then next_state <= s001000; output <= "0001101";
        end if;
      when s001000 =>
        if std_match(input, "---------0---------") then next_state <= s001000; output <= "0000101";
        elsif std_match(input, "---------1---------") then next_state <= s001001; output <= "0000101";
        end if;
      when s001001 =>
        if std_match(input, "-------------------") then next_state <= s010100; output <= "0011100";
        end if;
      when s010100 =>
        if std_match(input, "----------0--------") then next_state <= s010100; output <= "0000100";
        elsif std_match(input, "----------1--------") then next_state <= s010101; output <= "0000100";
        end if;
      when s010101 =>
        if std_match(input, "-------------------") then next_state <= s001010; output <= "0001101";
        end if;
      when s001010 =>
        if std_match(input, "-----------00------") then next_state <= s001010; output <= "0000101";
        elsif std_match(input, "-----------10------") then next_state <= s001001; output <= "0000101";
        elsif std_match(input, "-----------01------") then next_state <= s001010; output <= "0000101";
        elsif std_match(input, "-----------11------") then next_state <= s001011; output <= "0000101";
        end if;
      when s001011 =>
        if std_match(input, "-------------------") then next_state <= s011000; output <= "0101100";
        end if;
      when s011000 =>
        if std_match(input, "----------0--------") then next_state <= s011000; output <= "0000100";
        elsif std_match(input, "----------1--------") then next_state <= s011001; output <= "0000100";
        end if;
      when s011001 =>
        if std_match(input, "-------------------") then next_state <= s011010; output <= "0001101";
        end if;
      when s011010 =>
        if std_match(input, "-------------0-----") then next_state <= s011010; output <= "0000101";
        elsif std_match(input, "-------------1-----") then next_state <= s011011; output <= "0000101";
        end if;
      when s011011 =>
        if std_match(input, "-------------------") then next_state <= s001100; output <= "0001111";
        end if;
      when s001100 =>
        if std_match(input, "--------------0----") then next_state <= s001100; output <= "0000111";
        elsif std_match(input, "--------------1----") then next_state <= s001101; output <= "0000111";
        end if;
      when s001101 =>
        if std_match(input, "-------------------") then next_state <= s011110; output <= "0001101";
        end if;
      when s011110 =>
        if std_match(input, "---------------1---") then next_state <= s011111; output <= "0000101";
        elsif std_match(input, "---------------0---") then next_state <= s011110; output <= "0000101";
        end if;
      when s011111 =>
        if std_match(input, "-------------------") then next_state <= s100000; output <= "0011100";
        end if;
      when s100000 =>
        if std_match(input, "----------1--------") then next_state <= s100001; output <= "0000100";
        elsif std_match(input, "----------0--------") then next_state <= s100000; output <= "0000100";
        end if;
      when s100001 =>
        if std_match(input, "-------------------") then next_state <= s100010; output <= "0001101";
        end if;
      when s100010 =>
        if std_match(input, "------0------------") then next_state <= s100010; output <= "0000101";
        elsif std_match(input, "------1------------") then next_state <= s100011; output <= "0000101";
        end if;
      when s100011 =>
        if std_match(input, "-------------------") then next_state <= s001110; output <= "0001111";
        end if;
      when s001110 =>
        if std_match(input, "----------------00-") then next_state <= s001110; output <= "0000111";
        elsif std_match(input, "----------------10-") then next_state <= s001101; output <= "0000111";
        elsif std_match(input, "----------------01-") then next_state <= s001110; output <= "0000111";
        elsif std_match(input, "----------------11-") then next_state <= s001111; output <= "0000111";
        end if;
      when s001111 =>
        if std_match(input, "-------------------") then next_state <= s100110; output <= "0001101";
        end if;
      when s100110 =>
        if std_match(input, "---------------1---") then next_state <= s100111; output <= "0000101";
        elsif std_match(input, "---------------0---") then next_state <= s100110; output <= "0000101";
        end if;
      when s100111 =>
        if std_match(input, "-------------------") then next_state <= s101000; output <= "0001100";
        end if;
      when s101000 =>
        if std_match(input, "----------0--------") then next_state <= s101000; output <= "0000100";
        elsif std_match(input, "----------1--------") then next_state <= s101001; output <= "0000100";
        end if;
      when s101001 =>
        if std_match(input, "-------------------") then next_state <= s101010; output <= "0001101";
        end if;
      when s101010 =>
        if std_match(input, "------0------------") then next_state <= s101010; output <= "0000101";
        elsif std_match(input, "------1------------") then next_state <= s101011; output <= "0000101";
        end if;
      when s101011 =>
        if std_match(input, "-------------------") then next_state <= s101100; output <= "0001111";
        end if;
      when s101100 =>
        if std_match(input, "------------------1") then next_state <= s101101; output <= "0000111";
        elsif std_match(input, "------------------0") then next_state <= s101100; output <= "0000111";
        end if;
      when s101101 =>
        if std_match(input, "-------------------") then next_state <= s101110; output <= "1000111";
        end if;
      when s101110 =>
        if std_match(input, "-------------------") then next_state <= s010110; output <= "1000111";
        end if;
      when s010110 =>
        if std_match(input, "1------------------") then next_state <= s010111; output <= "0000000";
        elsif std_match(input, "0------------------") then next_state <= s010110; output <= "0000000";
        end if;
      when s010111 =>
        if std_match(input, "-------------------") then next_state <= s000110; output <= "0101100";
        end if;
      when s000110 =>
        if std_match(input, "-1-----------------") then next_state <= s000000; output <= "0000100";
        elsif std_match(input, "-0-----------------") then next_state <= s000110; output <= "0000100";
        end if;
      when others => next_state <= "------"; output <= "-------";
    end case;
  end process;
end behaviour;
