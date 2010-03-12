library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity kirkman_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(11 downto 0);
    output: out std_logic_vector(5 downto 0)
  );
end kirkman_nov;
architecture behaviour of kirkman_nov is
  constant rst0: std_logic_vector(4 downto 0) := "00000";
  constant bit1: std_logic_vector(4 downto 0) := "00001";
  constant bit2: std_logic_vector(4 downto 0) := "00010";
  constant bit3: std_logic_vector(4 downto 0) := "01011";
  constant bit4: std_logic_vector(4 downto 0) := "01101";
  constant bit5: std_logic_vector(4 downto 0) := "01110";
  constant bit6: std_logic_vector(4 downto 0) := "01111";
  constant bit7: std_logic_vector(4 downto 0) := "01000";
  constant bit8: std_logic_vector(4 downto 0) := "01001";
  constant bit9: std_logic_vector(4 downto 0) := "01010";
  constant bitA: std_logic_vector(4 downto 0) := "01100";
  constant bitB: std_logic_vector(4 downto 0) := "00100";
  constant bitC: std_logic_vector(4 downto 0) := "00101";
  constant bitD: std_logic_vector(4 downto 0) := "00110";
  constant bitE: std_logic_vector(4 downto 0) := "00111";
  constant bitF: std_logic_vector(4 downto 0) := "00011";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "------";
    if std_match(input, "--------1---") then next_state <= rst0; output <= "1-----";
    else
    case current_state is
      when rst0 =>
        if std_match(input, "--------0000") then next_state <= rst0; output <= "0----0";
        elsif std_match(input, "--------0001") then next_state <= bit1; output <= "0---00";
        elsif std_match(input, "-----0--0111") then next_state <= bit1; output <= "0--010";
        elsif std_match(input, "-----1--0111") then next_state <= bit1; output <= "0--110";
        elsif std_match(input, "--------0010") then next_state <= bit1; output <= "0---00";
        elsif std_match(input, "--------0100") then next_state <= bit1; output <= "0---00";
        end if;
      when bit1 =>
        if std_match(input, "--------0001") then next_state <= bit2; output <= "0---10";
        elsif std_match(input, "-----0--0111") then next_state <= bit2; output <= "0--010";
        elsif std_match(input, "-----1--0111") then next_state <= bit2; output <= "0--110";
        elsif std_match(input, "--------0010") then next_state <= bit2; output <= "0---00";
        elsif std_match(input, "--------0100") then next_state <= bit2; output <= "0---00";
        end if;
      when bit2 =>
        if std_match(input, "--------0001") then next_state <= bit3; output <= "0---00";
        elsif std_match(input, "-----0--0111") then next_state <= bit3; output <= "0--000";
        elsif std_match(input, "-----1--0111") then next_state <= bit3; output <= "0--100";
        elsif std_match(input, "--------0010") then next_state <= bit3; output <= "0---10";
        elsif std_match(input, "--------0100") then next_state <= bit3; output <= "0---10";
        end if;
      when bit3 =>
        if std_match(input, "0-------0001") then next_state <= bit4; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bit4; output <= "1---10";
        elsif std_match(input, "-00--00-0111") then next_state <= bit4; output <= "100000";
        elsif std_match(input, "-01--00-0111") then next_state <= bit4; output <= "100010";
        elsif std_match(input, "-10--00-0111") then next_state <= bit4; output <= "100010";
        elsif std_match(input, "-11--00-0111") then next_state <= bit4; output <= "110000";
        elsif std_match(input, "-00--01-0111") then next_state <= bit4; output <= "101000";
        elsif std_match(input, "-01--01-0111") then next_state <= bit4; output <= "100010";
        elsif std_match(input, "-10--01-0111") then next_state <= bit4; output <= "100010";
        elsif std_match(input, "-11--01-0111") then next_state <= bit4; output <= "111000";
        elsif std_match(input, "-----10-0111") then next_state <= bit4; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bit4; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bit4; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bit4; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bit4; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bit4; output <= "1---10";
        end if;
      when bit4 =>
        if std_match(input, "0-------0001") then next_state <= bit5; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bit5; output <= "1---10";
        elsif std_match(input, "-000000-0111") then next_state <= bit5; output <= "100000";
        elsif std_match(input, "-001000-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-010000-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-011000-0111") then next_state <= bit5; output <= "110000";
        elsif std_match(input, "-100000-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-101000-0111") then next_state <= bit5; output <= "110000";
        elsif std_match(input, "-110000-0111") then next_state <= bit5; output <= "110000";
        elsif std_match(input, "-111000-0111") then next_state <= bit5; output <= "110010";
        elsif std_match(input, "-000100-0111") then next_state <= bit5; output <= "101000";
        elsif std_match(input, "-001100-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-010100-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-011100-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-100100-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-101100-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-110100-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-111100-0111") then next_state <= bit5; output <= "110010";
        elsif std_match(input, "-000001-0111") then next_state <= bit5; output <= "101000";
        elsif std_match(input, "-001001-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-010001-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-011001-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-100001-0111") then next_state <= bit5; output <= "100010";
        elsif std_match(input, "-101001-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-110001-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-111001-0111") then next_state <= bit5; output <= "111010";
        elsif std_match(input, "-000101-0111") then next_state <= bit5; output <= "101000";
        elsif std_match(input, "-001101-0111") then next_state <= bit5; output <= "101010";
        elsif std_match(input, "-010101-0111") then next_state <= bit5; output <= "101010";
        elsif std_match(input, "-011101-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-100101-0111") then next_state <= bit5; output <= "101010";
        elsif std_match(input, "-101101-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-110101-0111") then next_state <= bit5; output <= "111000";
        elsif std_match(input, "-111101-0111") then next_state <= bit5; output <= "111010";
        elsif std_match(input, "-----10-0111") then next_state <= bit5; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bit5; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bit5; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bit5; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bit5; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bit5; output <= "1---10";
        end if;
      when bit5 =>
        if std_match(input, "0-------0001") then next_state <= bit6; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bit6; output <= "1---10";
        elsif std_match(input, "-000000-0111") then next_state <= bit6; output <= "100000";
        elsif std_match(input, "-001000-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-010000-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-011000-0111") then next_state <= bit6; output <= "110000";
        elsif std_match(input, "-100000-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-101000-0111") then next_state <= bit6; output <= "110000";
        elsif std_match(input, "-110000-0111") then next_state <= bit6; output <= "110000";
        elsif std_match(input, "-111000-0111") then next_state <= bit6; output <= "110010";
        elsif std_match(input, "-000100-0111") then next_state <= bit6; output <= "101000";
        elsif std_match(input, "-001100-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-010100-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-011100-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-100100-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-101100-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-110100-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-111100-0111") then next_state <= bit6; output <= "110010";
        elsif std_match(input, "-000001-0111") then next_state <= bit6; output <= "101000";
        elsif std_match(input, "-001001-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-010001-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-011001-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-100001-0111") then next_state <= bit6; output <= "100010";
        elsif std_match(input, "-101001-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-110001-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-111001-0111") then next_state <= bit6; output <= "111010";
        elsif std_match(input, "-000101-0111") then next_state <= bit6; output <= "101000";
        elsif std_match(input, "-001101-0111") then next_state <= bit6; output <= "101010";
        elsif std_match(input, "-010101-0111") then next_state <= bit6; output <= "101010";
        elsif std_match(input, "-011101-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-100101-0111") then next_state <= bit6; output <= "101010";
        elsif std_match(input, "-101101-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-110101-0111") then next_state <= bit6; output <= "111000";
        elsif std_match(input, "-111101-0111") then next_state <= bit6; output <= "111010";
        elsif std_match(input, "-----10-0111") then next_state <= bit6; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bit6; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bit6; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bit6; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bit6; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bit6; output <= "1---10";
        end if;
      when bit6 =>
        if std_match(input, "0-------0001") then next_state <= bit7; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bit7; output <= "1---10";
        elsif std_match(input, "-000000-0111") then next_state <= bit7; output <= "100000";
        elsif std_match(input, "-001000-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-010000-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-011000-0111") then next_state <= bit7; output <= "110000";
        elsif std_match(input, "-100000-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-101000-0111") then next_state <= bit7; output <= "110000";
        elsif std_match(input, "-110000-0111") then next_state <= bit7; output <= "110000";
        elsif std_match(input, "-111000-0111") then next_state <= bit7; output <= "110010";
        elsif std_match(input, "-000100-0111") then next_state <= bit7; output <= "101000";
        elsif std_match(input, "-001100-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-010100-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-011100-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-100100-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-101100-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-110100-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-111100-0111") then next_state <= bit7; output <= "110010";
        elsif std_match(input, "-000001-0111") then next_state <= bit7; output <= "101000";
        elsif std_match(input, "-001001-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-010001-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-011001-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-100001-0111") then next_state <= bit7; output <= "100010";
        elsif std_match(input, "-101001-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-110001-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-111001-0111") then next_state <= bit7; output <= "111010";
        elsif std_match(input, "-000101-0111") then next_state <= bit7; output <= "101000";
        elsif std_match(input, "-001101-0111") then next_state <= bit7; output <= "101010";
        elsif std_match(input, "-010101-0111") then next_state <= bit7; output <= "101010";
        elsif std_match(input, "-011101-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-100101-0111") then next_state <= bit7; output <= "101010";
        elsif std_match(input, "-101101-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-110101-0111") then next_state <= bit7; output <= "111000";
        elsif std_match(input, "-111101-0111") then next_state <= bit7; output <= "111010";
        elsif std_match(input, "-----10-0111") then next_state <= bit7; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bit7; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bit7; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bit7; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bit7; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bit7; output <= "1---10";
        end if;
      when bit7 =>
        if std_match(input, "0-------0001") then next_state <= bit8; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bit8; output <= "1---10";
        elsif std_match(input, "-000000-0111") then next_state <= bit8; output <= "100000";
        elsif std_match(input, "-001000-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-010000-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-011000-0111") then next_state <= bit8; output <= "110000";
        elsif std_match(input, "-100000-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-101000-0111") then next_state <= bit8; output <= "110000";
        elsif std_match(input, "-110000-0111") then next_state <= bit8; output <= "110000";
        elsif std_match(input, "-111000-0111") then next_state <= bit8; output <= "110010";
        elsif std_match(input, "-000100-0111") then next_state <= bit8; output <= "101000";
        elsif std_match(input, "-001100-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-010100-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-011100-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-100100-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-101100-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-110100-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-111100-0111") then next_state <= bit8; output <= "110010";
        elsif std_match(input, "-000001-0111") then next_state <= bit8; output <= "101000";
        elsif std_match(input, "-001001-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-010001-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-011001-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-100001-0111") then next_state <= bit8; output <= "100010";
        elsif std_match(input, "-101001-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-110001-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-111001-0111") then next_state <= bit8; output <= "111010";
        elsif std_match(input, "-000101-0111") then next_state <= bit8; output <= "101000";
        elsif std_match(input, "-001101-0111") then next_state <= bit8; output <= "101010";
        elsif std_match(input, "-010101-0111") then next_state <= bit8; output <= "101010";
        elsif std_match(input, "-011101-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-100101-0111") then next_state <= bit8; output <= "101010";
        elsif std_match(input, "-101101-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-110101-0111") then next_state <= bit8; output <= "111000";
        elsif std_match(input, "-111101-0111") then next_state <= bit8; output <= "111010";
        elsif std_match(input, "-----10-0111") then next_state <= bit8; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bit8; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bit8; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bit8; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bit8; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bit8; output <= "1---10";
        end if;
      when bit8 =>
        if std_match(input, "0-------0001") then next_state <= bit9; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bit9; output <= "1---10";
        elsif std_match(input, "-000000-0111") then next_state <= bit9; output <= "100000";
        elsif std_match(input, "-001000-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-010000-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-011000-0111") then next_state <= bit9; output <= "110000";
        elsif std_match(input, "-100000-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-101000-0111") then next_state <= bit9; output <= "110000";
        elsif std_match(input, "-110000-0111") then next_state <= bit9; output <= "110000";
        elsif std_match(input, "-111000-0111") then next_state <= bit9; output <= "110010";
        elsif std_match(input, "-000100-0111") then next_state <= bit9; output <= "101000";
        elsif std_match(input, "-001100-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-010100-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-011100-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-100100-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-101100-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-110100-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-111100-0111") then next_state <= bit9; output <= "110010";
        elsif std_match(input, "-000001-0111") then next_state <= bit9; output <= "101000";
        elsif std_match(input, "-001001-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-010001-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-011001-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-100001-0111") then next_state <= bit9; output <= "100010";
        elsif std_match(input, "-101001-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-110001-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-111001-0111") then next_state <= bit9; output <= "111010";
        elsif std_match(input, "-000101-0111") then next_state <= bit9; output <= "101000";
        elsif std_match(input, "-001101-0111") then next_state <= bit9; output <= "101010";
        elsif std_match(input, "-010101-0111") then next_state <= bit9; output <= "101010";
        elsif std_match(input, "-011101-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-100101-0111") then next_state <= bit9; output <= "101010";
        elsif std_match(input, "-101101-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-110101-0111") then next_state <= bit9; output <= "111000";
        elsif std_match(input, "-111101-0111") then next_state <= bit9; output <= "111010";
        elsif std_match(input, "-----10-0111") then next_state <= bit9; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bit9; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bit9; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bit9; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bit9; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bit9; output <= "1---10";
        end if;
      when bit9 =>
        if std_match(input, "0-------0001") then next_state <= bitA; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bitA; output <= "1---10";
        elsif std_match(input, "-000000-0111") then next_state <= bitA; output <= "100000";
        elsif std_match(input, "-001000-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-010000-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-011000-0111") then next_state <= bitA; output <= "110000";
        elsif std_match(input, "-100000-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-101000-0111") then next_state <= bitA; output <= "110000";
        elsif std_match(input, "-110000-0111") then next_state <= bitA; output <= "110000";
        elsif std_match(input, "-111000-0111") then next_state <= bitA; output <= "110010";
        elsif std_match(input, "-000100-0111") then next_state <= bitA; output <= "101000";
        elsif std_match(input, "-001100-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-010100-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-011100-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-100100-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-101100-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-110100-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-111100-0111") then next_state <= bitA; output <= "110010";
        elsif std_match(input, "-000001-0111") then next_state <= bitA; output <= "101000";
        elsif std_match(input, "-001001-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-010001-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-011001-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-100001-0111") then next_state <= bitA; output <= "100010";
        elsif std_match(input, "-101001-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-110001-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-111001-0111") then next_state <= bitA; output <= "111010";
        elsif std_match(input, "-000101-0111") then next_state <= bitA; output <= "101000";
        elsif std_match(input, "-001101-0111") then next_state <= bitA; output <= "101010";
        elsif std_match(input, "-010101-0111") then next_state <= bitA; output <= "101010";
        elsif std_match(input, "-011101-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-100101-0111") then next_state <= bitA; output <= "101010";
        elsif std_match(input, "-101101-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-110101-0111") then next_state <= bitA; output <= "111000";
        elsif std_match(input, "-111101-0111") then next_state <= bitA; output <= "111010";
        elsif std_match(input, "-----10-0111") then next_state <= bitA; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bitA; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bitA; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bitA; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bitA; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bitA; output <= "1---10";
        end if;
      when bitA =>
        if std_match(input, "0-------0001") then next_state <= bitB; output <= "1---00";
        elsif std_match(input, "1-------0001") then next_state <= bitB; output <= "1---10";
        elsif std_match(input, "-000000-0111") then next_state <= bitB; output <= "100000";
        elsif std_match(input, "-001000-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-010000-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-011000-0111") then next_state <= bitB; output <= "110000";
        elsif std_match(input, "-100000-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-101000-0111") then next_state <= bitB; output <= "110000";
        elsif std_match(input, "-110000-0111") then next_state <= bitB; output <= "110000";
        elsif std_match(input, "-111000-0111") then next_state <= bitB; output <= "110010";
        elsif std_match(input, "-000100-0111") then next_state <= bitB; output <= "101000";
        elsif std_match(input, "-001100-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-010100-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-011100-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-100100-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-101100-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-110100-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-111100-0111") then next_state <= bitB; output <= "110010";
        elsif std_match(input, "-000001-0111") then next_state <= bitB; output <= "101000";
        elsif std_match(input, "-001001-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-010001-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-011001-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-100001-0111") then next_state <= bitB; output <= "100010";
        elsif std_match(input, "-101001-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-110001-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-111001-0111") then next_state <= bitB; output <= "111010";
        elsif std_match(input, "-000101-0111") then next_state <= bitB; output <= "101000";
        elsif std_match(input, "-001101-0111") then next_state <= bitB; output <= "101010";
        elsif std_match(input, "-010101-0111") then next_state <= bitB; output <= "101010";
        elsif std_match(input, "-011101-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-100101-0111") then next_state <= bitB; output <= "101010";
        elsif std_match(input, "-101101-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-110101-0111") then next_state <= bitB; output <= "111000";
        elsif std_match(input, "-111101-0111") then next_state <= bitB; output <= "111010";
        elsif std_match(input, "-----10-0111") then next_state <= bitB; output <= "1--100";
        elsif std_match(input, "-----11-0111") then next_state <= bitB; output <= "1--110";
        elsif std_match(input, "-------00010") then next_state <= bitB; output <= "1---00";
        elsif std_match(input, "-------10010") then next_state <= bitB; output <= "1---10";
        elsif std_match(input, "------0-0100") then next_state <= bitB; output <= "1---00";
        elsif std_match(input, "------1-0100") then next_state <= bitB; output <= "1---10";
        end if;
      when bitB =>
        if std_match(input, "--------0001") then next_state <= bitC; output <= "0---00";
        elsif std_match(input, "--0000--0111") then next_state <= bitC; output <= "000000";
        elsif std_match(input, "--0100--0111") then next_state <= bitC; output <= "000010";
        elsif std_match(input, "--1000--0111") then next_state <= bitC; output <= "000010";
        elsif std_match(input, "--1100--0111") then next_state <= bitC; output <= "010000";
        elsif std_match(input, "--0010--0111") then next_state <= bitC; output <= "001000";
        elsif std_match(input, "--0110--0111") then next_state <= bitC; output <= "000010";
        elsif std_match(input, "--1010--0111") then next_state <= bitC; output <= "000010";
        elsif std_match(input, "--1110--0111") then next_state <= bitC; output <= "011000";
        elsif std_match(input, "-----1--0111") then next_state <= bitC; output <= "0--100";
        elsif std_match(input, "--------0010") then next_state <= bitC; output <= "0---00";
        elsif std_match(input, "--------0100") then next_state <= bitC; output <= "0---00";
        end if;
      when bitC =>
        if std_match(input, "--------0001") then next_state <= bitD; output <= "0---00";
        elsif std_match(input, "--0000--0111") then next_state <= bitD; output <= "000000";
        elsif std_match(input, "--0100--0111") then next_state <= bitD; output <= "000010";
        elsif std_match(input, "--1000--0111") then next_state <= bitD; output <= "000010";
        elsif std_match(input, "--1100--0111") then next_state <= bitD; output <= "010000";
        elsif std_match(input, "--0010--0111") then next_state <= bitD; output <= "001000";
        elsif std_match(input, "--0110--0111") then next_state <= bitD; output <= "000010";
        elsif std_match(input, "--1010--0111") then next_state <= bitD; output <= "000010";
        elsif std_match(input, "--1110--0111") then next_state <= bitD; output <= "011000";
        elsif std_match(input, "-----1--0111") then next_state <= bitD; output <= "0--100";
        elsif std_match(input, "--------0010") then next_state <= bitD; output <= "0---00";
        elsif std_match(input, "--------0100") then next_state <= bitD; output <= "0---00";
        end if;
      when bitD =>
        if std_match(input, "--------0001") then next_state <= bitE; output <= "0---00";
        elsif std_match(input, "--0000--0111") then next_state <= bitE; output <= "000000";
        elsif std_match(input, "--0100--0111") then next_state <= bitE; output <= "000010";
        elsif std_match(input, "--1000--0111") then next_state <= bitE; output <= "000010";
        elsif std_match(input, "--1100--0111") then next_state <= bitE; output <= "010000";
        elsif std_match(input, "--0010--0111") then next_state <= bitE; output <= "001000";
        elsif std_match(input, "--0110--0111") then next_state <= bitE; output <= "000010";
        elsif std_match(input, "--1010--0111") then next_state <= bitE; output <= "000010";
        elsif std_match(input, "--1110--0111") then next_state <= bitE; output <= "011000";
        elsif std_match(input, "-----1--0111") then next_state <= bitE; output <= "0--100";
        elsif std_match(input, "--------0010") then next_state <= bitE; output <= "0---00";
        elsif std_match(input, "--------0100") then next_state <= bitE; output <= "0---00";
        end if;
      when bitE =>
        if std_match(input, "--------0001") then next_state <= bitF; output <= "0---01";
        elsif std_match(input, "--0000--0111") then next_state <= bitF; output <= "000001";
        elsif std_match(input, "--0100--0111") then next_state <= bitF; output <= "000011";
        elsif std_match(input, "--1000--0111") then next_state <= bitF; output <= "000011";
        elsif std_match(input, "--1100--0111") then next_state <= bitF; output <= "010001";
        elsif std_match(input, "--0010--0111") then next_state <= bitF; output <= "001100";
        elsif std_match(input, "--0110--0111") then next_state <= bitF; output <= "000011";
        elsif std_match(input, "--1010--0111") then next_state <= bitF; output <= "000011";
        elsif std_match(input, "--1110--0111") then next_state <= bitF; output <= "011001";
        elsif std_match(input, "-----1--0111") then next_state <= bitF; output <= "0--001";
        elsif std_match(input, "--------0010") then next_state <= bitF; output <= "0---01";
        elsif std_match(input, "--------0100") then next_state <= bitF; output <= "0---01";
        end if;
      when bitF =>
        if std_match(input, "--------0001") then next_state <= rst0; output <= "0---00";
        elsif std_match(input, "---0-0--0111") then next_state <= rst0; output <= "0--000";
        elsif std_match(input, "---1-0--0111") then next_state <= rst0; output <= "0--010";
        elsif std_match(input, "-----1--0111") then next_state <= rst0; output <= "0--100";
        elsif std_match(input, "--------0010") then next_state <= rst0; output <= "0---00";
        elsif std_match(input, "--------0100") then next_state <= rst0; output <= "0---00";
        end if;
      when others => next_state <= "-----"; output <= "------";
    end case;
    end if;
  end process;
end behaviour;
