library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s420_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(18 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end s420_rnd;
architecture behaviour of s420_rnd is
  constant s1111111111111111: std_logic_vector(4 downto 0) := "11101";
  constant s0000000000000000: std_logic_vector(4 downto 0) := "00010";
  constant s0001000000000000: std_logic_vector(4 downto 0) := "11011";
  constant s0010000000000000: std_logic_vector(4 downto 0) := "11110";
  constant s0011000000000000: std_logic_vector(4 downto 0) := "11111";
  constant s0100000000000000: std_logic_vector(4 downto 0) := "10001";
  constant s0101000000000000: std_logic_vector(4 downto 0) := "10110";
  constant s0110000000000000: std_logic_vector(4 downto 0) := "01011";
  constant s0111000000000000: std_logic_vector(4 downto 0) := "01111";
  constant s1000000000000000: std_logic_vector(4 downto 0) := "00001";
  constant s1001000000000000: std_logic_vector(4 downto 0) := "10000";
  constant s1010000000000000: std_logic_vector(4 downto 0) := "11010";
  constant s1011000000000000: std_logic_vector(4 downto 0) := "11000";
  constant s1100000000000000: std_logic_vector(4 downto 0) := "01000";
  constant s1101000000000000: std_logic_vector(4 downto 0) := "00100";
  constant s1110000000000000: std_logic_vector(4 downto 0) := "01001";
  constant s1111000000000000: std_logic_vector(4 downto 0) := "00110";
  constant s0000000100000000: std_logic_vector(4 downto 0) := "11100";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "--";
    case current_state is
      when s1111111111111111 =>
        if std_match(input, "1----------------1-") then next_state <= s0000000000000000; output <= "11";
        elsif std_match(input, "1----------------00") then next_state <= s0000000000000000; output <= "10";
        elsif std_match(input, "1----------------01") then next_state <= s0000000000000000; output <= "11";
        elsif std_match(input, "0------------------") then next_state <= s0000000000000000; output <= "10";
        end if;
      when s0000000000000000 =>
        if std_match(input, "10----------------1") then next_state <= s0001000000000000; output <= "01";
        elsif std_match(input, "10----------------0") then next_state <= s0001000000000000; output <= "00";
        elsif std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "01----------------1") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "-1----------------0") then next_state <= s0000000000000000; output <= "00";
        end if;
      when s0001000000000000 =>
        if std_match(input, "0------------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------1-") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------01") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "10---------------00") then next_state <= s0010000000000000; output <= "00";
        elsif std_match(input, "10---------------10") then next_state <= s0010000000000000; output <= "01";
        elsif std_match(input, "10----------------1") then next_state <= s0010000000000000; output <= "01";
        end if;
      when s0010000000000000 =>
        if std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10--------------0-0") then next_state <= s0011000000000000; output <= "00";
        elsif std_match(input, "10--------------1-0") then next_state <= s0011000000000000; output <= "01";
        elsif std_match(input, "10----------------1") then next_state <= s0011000000000000; output <= "01";
        elsif std_match(input, "01-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11--------------0-0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11--------------1-0") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        end if;
      when s0011000000000000 =>
        if std_match(input, "0------------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------10") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "10---------------1-") then next_state <= s0100000000000000; output <= "01";
        elsif std_match(input, "10---------------01") then next_state <= s0100000000000000; output <= "01";
        elsif std_match(input, "10---------------00") then next_state <= s0100000000000000; output <= "00";
        end if;
      when s0100000000000000 =>
        if std_match(input, "10----------------1") then next_state <= s0101000000000000; output <= "01";
        elsif std_match(input, "10-------------0--0") then next_state <= s0101000000000000; output <= "00";
        elsif std_match(input, "10-------------1--0") then next_state <= s0101000000000000; output <= "01";
        elsif std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "01-------------0--1") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11-------------0--1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "-1-------------0--0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "01-------------1---") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11-------------1---") then next_state <= s0000000000000000; output <= "01";
        end if;
      when s0101000000000000 =>
        if std_match(input, "0------------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------10") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "10---------------10") then next_state <= s0110000000000000; output <= "01";
        elsif std_match(input, "10---------------00") then next_state <= s0110000000000000; output <= "00";
        elsif std_match(input, "10----------------1") then next_state <= s0110000000000000; output <= "01";
        end if;
      when s0110000000000000 =>
        if std_match(input, "0------------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11--------------1-0") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11--------------0-0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "10--------------1--") then next_state <= s0111000000000000; output <= "01";
        elsif std_match(input, "10--------------0-0") then next_state <= s0111000000000000; output <= "00";
        elsif std_match(input, "10--------------0-1") then next_state <= s0111000000000000; output <= "01";
        end if;
      when s0111000000000000 =>
        if std_match(input, "0------------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------1-") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------01") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "10---------------1-") then next_state <= s1000000000000000; output <= "01";
        elsif std_match(input, "10---------------01") then next_state <= s1000000000000000; output <= "01";
        elsif std_match(input, "10---------------00") then next_state <= s1000000000000000; output <= "00";
        end if;
      when s1000000000000000 =>
        if std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10----------------1") then next_state <= s1001000000000000; output <= "01";
        elsif std_match(input, "10------------1---0") then next_state <= s1001000000000000; output <= "01";
        elsif std_match(input, "10------------0---0") then next_state <= s1001000000000000; output <= "00";
        elsif std_match(input, "01------------0---1") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11------------0---1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11------------1---1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "01------------1---1") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11------------1---0") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11------------0---0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "01----------------0") then next_state <= s0000000000000000; output <= "00";
        end if;
      when s1001000000000000 =>
        if std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10---------------1-") then next_state <= s1010000000000000; output <= "01";
        elsif std_match(input, "10---------------00") then next_state <= s1010000000000000; output <= "00";
        elsif std_match(input, "10---------------01") then next_state <= s1010000000000000; output <= "01";
        elsif std_match(input, "01-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------1-") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------01") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        end if;
      when s1010000000000000 =>
        if std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10--------------1--") then next_state <= s1011000000000000; output <= "01";
        elsif std_match(input, "10--------------0-1") then next_state <= s1011000000000000; output <= "01";
        elsif std_match(input, "10--------------0-0") then next_state <= s1011000000000000; output <= "00";
        elsif std_match(input, "01-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11--------------1-0") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11--------------0-0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        end if;
      when s1011000000000000 =>
        if std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10---------------00") then next_state <= s1100000000000000; output <= "00";
        elsif std_match(input, "10---------------10") then next_state <= s1100000000000000; output <= "01";
        elsif std_match(input, "10----------------1") then next_state <= s1100000000000000; output <= "01";
        elsif std_match(input, "01-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------10") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        end if;
      when s1100000000000000 =>
        if std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10-------------0--1") then next_state <= s1101000000000000; output <= "01";
        elsif std_match(input, "10-------------0--0") then next_state <= s1101000000000000; output <= "00";
        elsif std_match(input, "10-------------1---") then next_state <= s1101000000000000; output <= "01";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "01----------------1") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11-------------0--0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11-------------1--0") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "01----------------0") then next_state <= s0000000000000000; output <= "00";
        end if;
      when s1101000000000000 =>
        if std_match(input, "0------------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10---------------1-") then next_state <= s1110000000000000; output <= "01";
        elsif std_match(input, "10---------------00") then next_state <= s1110000000000000; output <= "00";
        elsif std_match(input, "10---------------01") then next_state <= s1110000000000000; output <= "01";
        elsif std_match(input, "11---------------1-") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------01") then next_state <= s0000000000000000; output <= "01";
        end if;
      when s1110000000000000 =>
        if std_match(input, "10--------------1--") then next_state <= s1111000000000000; output <= "01";
        elsif std_match(input, "10--------------0-0") then next_state <= s1111000000000000; output <= "00";
        elsif std_match(input, "10--------------0-1") then next_state <= s1111000000000000; output <= "01";
        elsif std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "01-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11--------------1--") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11--------------0-0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11--------------0-1") then next_state <= s0000000000000000; output <= "01";
        end if;
      when s1111000000000000 =>
        if std_match(input, "01-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------00") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11---------------10") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "00-----------------") then next_state <= s0000000100000000; output <= "00";
        elsif std_match(input, "10---------------10") then next_state <= s0000000100000000; output <= "01";
        elsif std_match(input, "10---------------00") then next_state <= s0000000100000000; output <= "00";
        elsif std_match(input, "10----------------1") then next_state <= s0000000100000000; output <= "01";
        end if;
      when s0000000100000000 =>
        if std_match(input, "00-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "10-----------1-----") then next_state <= s0001000000000000; output <= "01";
        elsif std_match(input, "10-----------0----0") then next_state <= s0001000000000000; output <= "00";
        elsif std_match(input, "10-----------0----1") then next_state <= s0001000000000000; output <= "01";
        elsif std_match(input, "01-----------------") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11-----------1----0") then next_state <= s0000000000000000; output <= "01";
        elsif std_match(input, "11-----------0----0") then next_state <= s0000000000000000; output <= "00";
        elsif std_match(input, "11----------------1") then next_state <= s0000000000000000; output <= "01";
        end if;
      when others => next_state <= "-----"; output <= "--";
    end case;
  end process;
end behaviour;
