library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s820_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(17 downto 0);
    output: out std_logic_vector(18 downto 0)
  );
end s820_jed;
architecture behaviour of s820_jed is
  constant s00000: std_logic_vector(4 downto 0) := "00000";
  constant s01110: std_logic_vector(4 downto 0) := "11010";
  constant s10000: std_logic_vector(4 downto 0) := "11001";
  constant s10001: std_logic_vector(4 downto 0) := "01011";
  constant s01111: std_logic_vector(4 downto 0) := "11101";
  constant s00010: std_logic_vector(4 downto 0) := "10000";
  constant s00001: std_logic_vector(4 downto 0) := "00001";
  constant s00100: std_logic_vector(4 downto 0) := "00100";
  constant s00011: std_logic_vector(4 downto 0) := "01101";
  constant s00101: std_logic_vector(4 downto 0) := "00110";
  constant s00110: std_logic_vector(4 downto 0) := "00011";
  constant s11111: std_logic_vector(4 downto 0) := "10001";
  constant s10111: std_logic_vector(4 downto 0) := "10011";
  constant s01011: std_logic_vector(4 downto 0) := "00010";
  constant s00111: std_logic_vector(4 downto 0) := "10010";
  constant s11000: std_logic_vector(4 downto 0) := "10101";
  constant s11011: std_logic_vector(4 downto 0) := "01000";
  constant s11001: std_logic_vector(4 downto 0) := "10100";
  constant s11010: std_logic_vector(4 downto 0) := "01010";
  constant s11100: std_logic_vector(4 downto 0) := "01100";
  constant s01100: std_logic_vector(4 downto 0) := "11000";
  constant s01101: std_logic_vector(4 downto 0) := "11100";
  constant s01000: std_logic_vector(4 downto 0) := "00111";
  constant s01001: std_logic_vector(4 downto 0) := "00101";
  constant s01010: std_logic_vector(4 downto 0) := "01001";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "-------------------";
    case current_state is
      when s00000 =>
        if std_match(input, "-1---------------1") then next_state <= s00000; output <= "0000000000000110000";
        elsif std_match(input, "-0-0------------11") then next_state <= s00000; output <= "0000000000000100001";
        elsif std_match(input, "-0-0------------01") then next_state <= s00000; output <= "0000000000000100000";
        elsif std_match(input, "-0-1------------01") then next_state <= s00000; output <= "0000000001000100000";
        elsif std_match(input, "-0-1------------11") then next_state <= s00000; output <= "0000000000000100001";
        elsif std_match(input, "-000------------00") then next_state <= s00000; output <= "0000000000000100000";
        elsif std_match(input, "-010------------00") then next_state <= s01110; output <= "0000000000000100000";
        elsif std_match(input, "-0-1------------00") then next_state <= s00000; output <= "0000000001000100000";
        elsif std_match(input, "-1--------------00") then next_state <= s10000; output <= "0000000000000110000";
        elsif std_match(input, "-0--------------10") then next_state <= s10001; output <= "0000000000000100001";
        elsif std_match(input, "-1--------------10") then next_state <= s10000; output <= "0000000000000110000";
        end if;
      when s01110 =>
        if std_match(input, "-----------------1") then next_state <= s00000; output <= "0000010000000000000";
        elsif std_match(input, "-----------------0") then next_state <= s01111; output <= "0000010000000000000";
        end if;
      when s01111 =>
        if std_match(input, "----------------11") then next_state <= s00000; output <= "0000000100000100000";
        elsif std_match(input, "----------------01") then next_state <= s00000; output <= "0000000000000100000";
        elsif std_match(input, "----------------00") then next_state <= s00010; output <= "0000000000000100000";
        elsif std_match(input, "----------------10") then next_state <= s00001; output <= "0000000100000100000";
        end if;
      when s00010 =>
        if std_match(input, "--------------01-1") then next_state <= s00000; output <= "0000000000110000000";
        elsif std_match(input, "--------------11-1") then next_state <= s00000; output <= "0000000000111000000";
        elsif std_match(input, "---------------0-1") then next_state <= s00000; output <= "0000000000010000000";
        elsif std_match(input, "--------------01-0") then next_state <= s00100; output <= "0000000000110000000";
        elsif std_match(input, "--------------11-0") then next_state <= s00011; output <= "0000000000111000000";
        elsif std_match(input, "---------------0-0") then next_state <= s00010; output <= "0000000000010000000";
        end if;
      when s00100 =>
        if std_match(input, "----1------------1") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-----------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1------------0") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------00") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----0-0---------10") then next_state <= s00100; output <= "0000000000000001000";
        elsif std_match(input, "----0-11-1-----110") then next_state <= s00100; output <= "0000000000000001000";
        elsif std_match(input, "----0-1011-----110") then next_state <= s00100; output <= "0000000000000001000";
        elsif std_match(input, "----0-1001-----110") then next_state <= s00101; output <= "0000000000000001000";
        elsif std_match(input, "----0-1--0-----110") then next_state <= s00100; output <= "0000000000000001000";
        elsif std_match(input, "----0-1--------010") then next_state <= s00100; output <= "0000000000000001000";
        end if;
      when s00001 =>
        if std_match(input, "----------------01") then next_state <= s00000; output <= "0000000000000000000";
        elsif std_match(input, "----------------00") then next_state <= s00010; output <= "0000000000000000000";
        elsif std_match(input, "----------------11") then next_state <= s00000; output <= "0000000000000000000";
        elsif std_match(input, "----------------10") then next_state <= s00001; output <= "0000000000000000000";
        end if;
      when s00101 =>
        if std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0----------010") then next_state <= s00101; output <= "0000000000000001000";
        elsif std_match(input, "----0----------110") then next_state <= s00110; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------10") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------11") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----------------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------00") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------00") then next_state <= s00010; output <= "0000000000000001001";
        end if;
      when s00110 =>
        if std_match(input, "----------------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1----------011") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------011") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1-----1----111") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----100--111") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-----110--111") then next_state <= s00000; output <= "0000000000000001100";
        elsif std_match(input, "----0-----1-1--111") then next_state <= s00000; output <= "0000000000000001100";
        elsif std_match(input, "----1-----0-1--111") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----011--111") then next_state <= s00000; output <= "0000000000000001100";
        elsif std_match(input, "----0-----001--111") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-----0-0--111") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1-----0-0--111") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1------1----10") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0------1---010") then next_state <= s00110; output <= "0000000000000001000";
        elsif std_match(input, "----0-----11---110") then next_state <= s11111; output <= "0000000000000001100";
        elsif std_match(input, "----0-----011--110") then next_state <= s11111; output <= "0000000000000001100";
        elsif std_match(input, "----0-----010--110") then next_state <= s10111; output <= "0000000000000001000";
        elsif std_match(input, "----0------1----00") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----1------1----00") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----1------0-----0") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0------0---010") then next_state <= s00110; output <= "0000000000000001000";
        elsif std_match(input, "----0------0---000") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----0------01--100") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----0-----001--110") then next_state <= s01011; output <= "0000000000000001000";
        elsif std_match(input, "----0-----101--110") then next_state <= s11111; output <= "0000000000000001100";
        elsif std_match(input, "----0-----000--110") then next_state <= s01011; output <= "0000000000000001000";
        elsif std_match(input, "----0-----000--100") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----0-----100--110") then next_state <= s00111; output <= "0000000000000001000";
        elsif std_match(input, "----0-----100--100") then next_state <= s00010; output <= "0000000000000001001";
        end if;
      when s11111 =>
        if std_match(input, "-----------------1") then next_state <= s00000; output <= "0000000000000000000";
        elsif std_match(input, "1----------------0") then next_state <= s00000; output <= "0000000000000000000";
        elsif std_match(input, "0----------------0") then next_state <= s11111; output <= "0000000000000000000";
        end if;
      when s10111 =>
        if std_match(input, "----1-----------11") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----------------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------010") then next_state <= s10111; output <= "0000000000000001000";
        elsif std_match(input, "----0--------1-110") then next_state <= s11000; output <= "0000000000000001000";
        elsif std_match(input, "----0--------0-110") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------10") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------00") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------00") then next_state <= s00001; output <= "0000000000000001001";
        end if;
      when s11000 =>
        if std_match(input, "----0----------111") then next_state <= s00000; output <= "1000000000000001000";
        elsif std_match(input, "----0----------101") then next_state <= s00000; output <= "1000000000000001001";
        elsif std_match(input, "----1----------1-1") then next_state <= s00000; output <= "1000000000000001001";
        elsif std_match(input, "---------------001") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1----------011") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------011") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1----------1-0") then next_state <= s00001; output <= "1000000000000001001";
        elsif std_match(input, "----1----------0-0") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0----------000") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----0----------100") then next_state <= s00010; output <= "1000000000000001001";
        elsif std_match(input, "----0----------110") then next_state <= s11001; output <= "1000000000000001000";
        elsif std_match(input, "----0----------010") then next_state <= s11000; output <= "0000000000000001000";
        end if;
      when s11001 =>
        if std_match(input, "---------------001") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1----------011") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------011") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0----------111") then next_state <= s00000; output <= "0100000000000001000";
        elsif std_match(input, "----0----------101") then next_state <= s00000; output <= "0100000000000001001";
        elsif std_match(input, "----1----------1-1") then next_state <= s00000; output <= "0100000000000001001";
        elsif std_match(input, "----1----------0-0") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----1----------1-0") then next_state <= s00001; output <= "0100000000000001001";
        elsif std_match(input, "----0----------110") then next_state <= s11010; output <= "0100000000000001000";
        elsif std_match(input, "----0----------010") then next_state <= s11001; output <= "0000000000000001000";
        elsif std_match(input, "----0----------100") then next_state <= s00010; output <= "0100000000000001001";
        elsif std_match(input, "----0----------000") then next_state <= s00010; output <= "0000000000000001001";
        end if;
      when s11010 =>
        if std_match(input, "----------------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------11") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1------------0") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0----------010") then next_state <= s11010; output <= "0000000000000001000";
        elsif std_match(input, "----0----------110") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-----------00") then next_state <= s00010; output <= "0000000000000001001";
        end if;
      when s11011 =>
        if std_match(input, "----1------------1") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-0---------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-0---------01") then next_state <= s00000; output <= "0000000000000001010";
        elsif std_match(input, "----0-10--------01") then next_state <= s00000; output <= "0000000000000001010";
        elsif std_match(input, "----0-10--------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-110-------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-110-------01") then next_state <= s00000; output <= "0000000000000001010";
        elsif std_match(input, "----0-1110------01") then next_state <= s00000; output <= "0000000000000001010";
        elsif std_match(input, "----0-1110------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-1111-----001") then next_state <= s00000; output <= "0000000000000001010";
        elsif std_match(input, "----0-1111-----011") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-1111-----1-1") then next_state <= s00000; output <= "0000000000000001010";
        elsif std_match(input, "----1-----------10") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0-0--------010") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-0--------110") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-10-------010") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-10-------110") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-110------110") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-1110-----110") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-1111-----110") then next_state <= s11100; output <= "0000000000000001010";
        elsif std_match(input, "----0-11-------010") then next_state <= s11011; output <= "0000000000000001000";
        elsif std_match(input, "----0-----------00") then next_state <= s01100; output <= "0000000000000001010";
        elsif std_match(input, "----1-----------00") then next_state <= s00001; output <= "0000000000000001001";
        end if;
      when s11100 =>
        if std_match(input, "----1-----------11") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0-----------10") then next_state <= s11100; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------10") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------01") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------00") then next_state <= s01100; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------00") then next_state <= s00001; output <= "0000000000000001001";
        end if;
      when s01100 =>
        if std_match(input, "-----0-----------0") then next_state <= s01101; output <= "0010100000000000000";
        elsif std_match(input, "-----0-----------1") then next_state <= s00000; output <= "0010100000000000000";
        elsif std_match(input, "-----1-----------0") then next_state <= s00010; output <= "0001100000000000000";
        elsif std_match(input, "-----1-----------1") then next_state <= s00000; output <= "0001100000000000000";
        end if;
      when s01101 =>
        if std_match(input, "-1---------------0") then next_state <= s10000; output <= "0000001010000010000";
        elsif std_match(input, "-1---------------1") then next_state <= s00000; output <= "0000001010000010000";
        elsif std_match(input, "-000-------------0") then next_state <= s01101; output <= "0000001010000000000";
        elsif std_match(input, "-010-------------0") then next_state <= s01110; output <= "0000001010000000000";
        elsif std_match(input, "-0-0-------------1") then next_state <= s00000; output <= "0000001010000000000";
        elsif std_match(input, "-0-1--------------") then next_state <= s00000; output <= "0000001010000000000";
        end if;
      when s10000 =>
        if std_match(input, "0----------------0") then next_state <= s10000; output <= "0000000000000000000";
        elsif std_match(input, "0----------------1") then next_state <= s00000; output <= "0000000000000000000";
        elsif std_match(input, "1-----------------") then next_state <= s00000; output <= "0000000000000000000";
        end if;
      when s01011 =>
        if std_match(input, "----1-----------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------01") then next_state <= s00000; output <= "0000000000000001010";
        elsif std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------11") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1------------0") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------00") then next_state <= s01100; output <= "0000000000000001010";
        elsif std_match(input, "----0----------010") then next_state <= s01011; output <= "0000000000000001000";
        elsif std_match(input, "----0----------110") then next_state <= s01011; output <= "0000000000000001000";
        end if;
      when s00111 =>
        if std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------11") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------10") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0--------0-110") then next_state <= s01011; output <= "0000000000000001000";
        elsif std_match(input, "----0--------1-110") then next_state <= s01000; output <= "0000000000000001000";
        elsif std_match(input, "----0----------010") then next_state <= s00111; output <= "0000000000000001000";
        elsif std_match(input, "----------------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------00") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------00") then next_state <= s00001; output <= "0000000000000001001";
        end if;
      when s01000 =>
        if std_match(input, "----0----------011") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----0----------001") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1----------0-1") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------101") then next_state <= s00000; output <= "1000000000000001001";
        elsif std_match(input, "----0----------111") then next_state <= s00000; output <= "1000000000000001000";
        elsif std_match(input, "----1----------1-1") then next_state <= s00000; output <= "1000000000000001001";
        elsif std_match(input, "----0----------010") then next_state <= s01000; output <= "0000000000000001000";
        elsif std_match(input, "----0----------110") then next_state <= s01001; output <= "1000000000000001000";
        elsif std_match(input, "----1----------110") then next_state <= s00001; output <= "1000000000000001001";
        elsif std_match(input, "----1----------010") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----1----------100") then next_state <= s00001; output <= "1000000000000001001";
        elsif std_match(input, "----1----------000") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0----------100") then next_state <= s00010; output <= "1000000000000001001";
        elsif std_match(input, "----0----------000") then next_state <= s00010; output <= "0000000000000001001";
        end if;
      when s01001 =>
        if std_match(input, "----0----------101") then next_state <= s00000; output <= "0100000000000001001";
        elsif std_match(input, "----0----------111") then next_state <= s00000; output <= "0100000000000001000";
        elsif std_match(input, "----1----------1-1") then next_state <= s00000; output <= "0100000000000001001";
        elsif std_match(input, "---------------001") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------011") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1----------011") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1----------010") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----1----------110") then next_state <= s00001; output <= "0100000000000001001";
        elsif std_match(input, "----0----------010") then next_state <= s01001; output <= "0000000000000001000";
        elsif std_match(input, "----0----------110") then next_state <= s01010; output <= "0100000000000001000";
        elsif std_match(input, "----0----------000") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----0----------100") then next_state <= s00010; output <= "0100000000000001001";
        elsif std_match(input, "----1----------100") then next_state <= s00001; output <= "0100000000000001001";
        elsif std_match(input, "----1----------000") then next_state <= s00001; output <= "0000000000000001001";
        end if;
      when s01010 =>
        if std_match(input, "----0----------010") then next_state <= s01010; output <= "0000000000000001000";
        elsif std_match(input, "----0----------110") then next_state <= s01011; output <= "0000000000000001000";
        elsif std_match(input, "----0-----------11") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1-----------10") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------11") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------00") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----0-----------01") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------00") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----1-----------01") then next_state <= s00000; output <= "0000000000000001001";
        end if;
      when s00011 =>
        if std_match(input, "----1----------111") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------111") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "---------------101") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----0----------110") then next_state <= s00100; output <= "0000000000000001000";
        elsif std_match(input, "----1----------110") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0----------100") then next_state <= s00010; output <= "0000000000000001001";
        elsif std_match(input, "----1----------100") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0----------011") then next_state <= s00000; output <= "0000000000000001000";
        elsif std_match(input, "----1----------011") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "---------------001") then next_state <= s00000; output <= "0000000000000001001";
        elsif std_match(input, "----1----------0-0") then next_state <= s00001; output <= "0000000000000001001";
        elsif std_match(input, "----0----------010") then next_state <= s00011; output <= "0000000000000001000";
        elsif std_match(input, "----0----------000") then next_state <= s00010; output <= "0000000000000001001";
        end if;
      when s10001 =>
        if std_match(input, "-----------------1") then next_state <= s00000; output <= "0000000000000000000";
        elsif std_match(input, "----------------10") then next_state <= s10001; output <= "0000000000000000000";
        elsif std_match(input, "----------------00") then next_state <= s00000; output <= "0000000000000000000";
        end if;
      when others => next_state <= "-----"; output <= "-------------------";
    end case;
  end process;
end behaviour;
