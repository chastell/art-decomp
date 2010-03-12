library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s208_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(10 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end s208_nov;
architecture behaviour of s208_nov is
  constant s11111111: std_logic_vector(4 downto 0) := "11111";
  constant s00000000: std_logic_vector(4 downto 0) := "00000";
  constant s00010000: std_logic_vector(4 downto 0) := "00011";
  constant s00100000: std_logic_vector(4 downto 0) := "00010";
  constant s00110000: std_logic_vector(4 downto 0) := "00101";
  constant s01000000: std_logic_vector(4 downto 0) := "00100";
  constant s01010000: std_logic_vector(4 downto 0) := "00111";
  constant s01100000: std_logic_vector(4 downto 0) := "00110";
  constant s01110000: std_logic_vector(4 downto 0) := "01001";
  constant s10000000: std_logic_vector(4 downto 0) := "01000";
  constant s10010000: std_logic_vector(4 downto 0) := "01011";
  constant s10100000: std_logic_vector(4 downto 0) := "01010";
  constant s10110000: std_logic_vector(4 downto 0) := "01101";
  constant s11000000: std_logic_vector(4 downto 0) := "01100";
  constant s11010000: std_logic_vector(4 downto 0) := "01111";
  constant s11100000: std_logic_vector(4 downto 0) := "01110";
  constant s11110000: std_logic_vector(4 downto 0) := "10111";
  constant s00000001: std_logic_vector(4 downto 0) := "00001";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "--";
    case current_state is
      when s11111111 =>
        if std_match(input, "0--------01") then next_state <= s00000000; output <= "10";
        elsif std_match(input, "1--------01") then next_state <= s00000000; output <= "11";
        elsif std_match(input, "0--------11") then next_state <= s00000000; output <= "10";
        elsif std_match(input, "1--------11") then next_state <= s00000000; output <= "11";
        elsif std_match(input, "1--------10") then next_state <= s00000000; output <= "11";
        elsif std_match(input, "1--------00") then next_state <= s00000000; output <= "10";
        elsif std_match(input, "0---------0") then next_state <= s00000000; output <= "10";
        end if;
      when s00000000 =>
        if std_match(input, "0----------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11--------0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "10--------1") then next_state <= s00010000; output <= "01";
        elsif std_match(input, "10--------0") then next_state <= s00010000; output <= "00";
        end if;
      when s00010000 =>
        if std_match(input, "10-------00") then next_state <= s00100000; output <= "00";
        elsif std_match(input, "10-------01") then next_state <= s00100000; output <= "01";
        elsif std_match(input, "10-------1-") then next_state <= s00100000; output <= "01";
        elsif std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01-------0-") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------01") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11-------11") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01-------11") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01-------10") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------10") then next_state <= s00000000; output <= "01";
        end if;
      when s00100000 =>
        if std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10------1--") then next_state <= s00110000; output <= "01";
        elsif std_match(input, "10------0-0") then next_state <= s00110000; output <= "00";
        elsif std_match(input, "10------0-1") then next_state <= s00110000; output <= "01";
        elsif std_match(input, "01---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11------1-0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11------0-0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        end if;
      when s00110000 =>
        if std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10-------01") then next_state <= s01000000; output <= "01";
        elsif std_match(input, "10-------00") then next_state <= s01000000; output <= "00";
        elsif std_match(input, "10-------1-") then next_state <= s01000000; output <= "01";
        elsif std_match(input, "01-------01") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------01") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11-------11") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01-------11") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "-1-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------10") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01-------10") then next_state <= s00000000; output <= "00";
        end if;
      when s01000000 =>
        if std_match(input, "0----------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-----1--0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11-----0--0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "10-----1--0") then next_state <= s01010000; output <= "01";
        elsif std_match(input, "10-----0--0") then next_state <= s01010000; output <= "00";
        elsif std_match(input, "10--------1") then next_state <= s01010000; output <= "01";
        end if;
      when s01010000 =>
        if std_match(input, "0----------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------01") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------1-") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "10-------01") then next_state <= s01100000; output <= "01";
        elsif std_match(input, "10-------00") then next_state <= s01100000; output <= "00";
        elsif std_match(input, "10-------1-") then next_state <= s01100000; output <= "01";
        end if;
      when s01100000 =>
        if std_match(input, "0----------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10------1-0") then next_state <= s01110000; output <= "01";
        elsif std_match(input, "10------0-0") then next_state <= s01110000; output <= "00";
        elsif std_match(input, "10--------1") then next_state <= s01110000; output <= "01";
        elsif std_match(input, "11------0-0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11------1-0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        end if;
      when s01110000 =>
        if std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10--------1") then next_state <= s10000000; output <= "01";
        elsif std_match(input, "10-------10") then next_state <= s10000000; output <= "01";
        elsif std_match(input, "10-------00") then next_state <= s10000000; output <= "00";
        elsif std_match(input, "01-------0-") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------01") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01-------1-") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------1-") then next_state <= s00000000; output <= "01";
        end if;
      when s10000000 =>
        if std_match(input, "0----------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10----0---0") then next_state <= s10010000; output <= "00";
        elsif std_match(input, "10----1---0") then next_state <= s10010000; output <= "01";
        elsif std_match(input, "10--------1") then next_state <= s10010000; output <= "01";
        elsif std_match(input, "11----1---0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11----0---0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        end if;
      when s10010000 =>
        if std_match(input, "10--------1") then next_state <= s10100000; output <= "01";
        elsif std_match(input, "10-------10") then next_state <= s10100000; output <= "01";
        elsif std_match(input, "10-------00") then next_state <= s10100000; output <= "00";
        elsif std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------01") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01-------01") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01-------11") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------11") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "-1-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------10") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01-------10") then next_state <= s00000000; output <= "00";
        end if;
      when s10100000 =>
        if std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10------1--") then next_state <= s10110000; output <= "01";
        elsif std_match(input, "10------0-0") then next_state <= s10110000; output <= "00";
        elsif std_match(input, "10------0-1") then next_state <= s10110000; output <= "01";
        elsif std_match(input, "11------1-0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11------0-0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01---------") then next_state <= s00000000; output <= "00";
        end if;
      when s10110000 =>
        if std_match(input, "10--------1") then next_state <= s11000000; output <= "01";
        elsif std_match(input, "10-------00") then next_state <= s11000000; output <= "00";
        elsif std_match(input, "10-------10") then next_state <= s11000000; output <= "01";
        elsif std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01-------0-") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------01") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01-------1-") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------1-") then next_state <= s00000000; output <= "01";
        end if;
      when s11000000 =>
        if std_match(input, "10-----0--0") then next_state <= s11010000; output <= "00";
        elsif std_match(input, "10-----1--0") then next_state <= s11010000; output <= "01";
        elsif std_match(input, "10--------1") then next_state <= s11010000; output <= "01";
        elsif std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-----1--0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11-----0--0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        end if;
      when s11010000 =>
        if std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10-------01") then next_state <= s11100000; output <= "01";
        elsif std_match(input, "10-------00") then next_state <= s11100000; output <= "00";
        elsif std_match(input, "10-------1-") then next_state <= s11100000; output <= "01";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01--------1") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "-1-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------10") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01-------10") then next_state <= s00000000; output <= "00";
        end if;
      when s11100000 =>
        if std_match(input, "0----------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11------0-0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11------1-0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "10------1--") then next_state <= s11110000; output <= "01";
        elsif std_match(input, "10------0-1") then next_state <= s11110000; output <= "01";
        elsif std_match(input, "10------0-0") then next_state <= s11110000; output <= "00";
        end if;
      when s11110000 =>
        if std_match(input, "01-------01") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------01") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01-------11") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------11") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "-1-------00") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "01-------10") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11-------10") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "10-------01") then next_state <= s00000001; output <= "01";
        elsif std_match(input, "00-------01") then next_state <= s00000001; output <= "00";
        elsif std_match(input, "-0-------00") then next_state <= s00000001; output <= "00";
        elsif std_match(input, "10-------11") then next_state <= s00000001; output <= "01";
        elsif std_match(input, "00-------11") then next_state <= s00000001; output <= "00";
        elsif std_match(input, "00-------10") then next_state <= s00000001; output <= "00";
        elsif std_match(input, "10-------10") then next_state <= s00000001; output <= "01";
        end if;
      when s00000001 =>
        if std_match(input, "00---------") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "10---1----0") then next_state <= s00010000; output <= "01";
        elsif std_match(input, "10---0----0") then next_state <= s00010000; output <= "00";
        elsif std_match(input, "10--------1") then next_state <= s00010000; output <= "01";
        elsif std_match(input, "11---0----0") then next_state <= s00000000; output <= "00";
        elsif std_match(input, "11---1----0") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "11--------1") then next_state <= s00000000; output <= "01";
        elsif std_match(input, "01---------") then next_state <= s00000000; output <= "00";
        end if;
      when others => next_state <= "-----"; output <= "--";
    end case;
  end process;
end behaviour;
