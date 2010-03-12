library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity scf_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(26 downto 0);
    output: out std_logic_vector(55 downto 0)
  );
end scf_nov;
architecture behaviour of scf_nov is
  constant state1: std_logic_vector(6 downto 0) := "1000101";
  constant state2: std_logic_vector(6 downto 0) := "1100001";
  constant state3: std_logic_vector(6 downto 0) := "1111101";
  constant state4: std_logic_vector(6 downto 0) := "1110101";
  constant state5: std_logic_vector(6 downto 0) := "0010111";
  constant state6: std_logic_vector(6 downto 0) := "1001101";
  constant state7: std_logic_vector(6 downto 0) := "1101001";
  constant state8: std_logic_vector(6 downto 0) := "1100111";
  constant state9: std_logic_vector(6 downto 0) := "1100100";
  constant state10: std_logic_vector(6 downto 0) := "1011101";
  constant state11: std_logic_vector(6 downto 0) := "1000001";
  constant state12: std_logic_vector(6 downto 0) := "1101111";
  constant state13: std_logic_vector(6 downto 0) := "1110100";
  constant state14: std_logic_vector(6 downto 0) := "0101101";
  constant state15: std_logic_vector(6 downto 0) := "0101001";
  constant state16: std_logic_vector(6 downto 0) := "1101101";
  constant state17: std_logic_vector(6 downto 0) := "1010101";
  constant state18: std_logic_vector(6 downto 0) := "1101110";
  constant state19: std_logic_vector(6 downto 0) := "1110001";
  constant state20: std_logic_vector(6 downto 0) := "0001110";
  constant state21: std_logic_vector(6 downto 0) := "1100011";
  constant state22: std_logic_vector(6 downto 0) := "0010000";
  constant state23: std_logic_vector(6 downto 0) := "1101100";
  constant state24: std_logic_vector(6 downto 0) := "0010011";
  constant state25: std_logic_vector(6 downto 0) := "0001101";
  constant state26: std_logic_vector(6 downto 0) := "1111110";
  constant state27: std_logic_vector(6 downto 0) := "1100000";
  constant state28: std_logic_vector(6 downto 0) := "0010101";
  constant state29: std_logic_vector(6 downto 0) := "0010001";
  constant state30: std_logic_vector(6 downto 0) := "0101111";
  constant state31: std_logic_vector(6 downto 0) := "1001010";
  constant state32: std_logic_vector(6 downto 0) := "1011110";
  constant state33: std_logic_vector(6 downto 0) := "0001010";
  constant state34: std_logic_vector(6 downto 0) := "0000001";
  constant state35: std_logic_vector(6 downto 0) := "1011010";
  constant state36: std_logic_vector(6 downto 0) := "1101010";
  constant state37: std_logic_vector(6 downto 0) := "1111111";
  constant state38: std_logic_vector(6 downto 0) := "0100000";
  constant state39: std_logic_vector(6 downto 0) := "1011111";
  constant state40: std_logic_vector(6 downto 0) := "0111010";
  constant state41: std_logic_vector(6 downto 0) := "1000000";
  constant state42: std_logic_vector(6 downto 0) := "0111110";
  constant state43: std_logic_vector(6 downto 0) := "0101010";
  constant state44: std_logic_vector(6 downto 0) := "0111111";
  constant state45: std_logic_vector(6 downto 0) := "1110000";
  constant state46: std_logic_vector(6 downto 0) := "0001111";
  constant state47: std_logic_vector(6 downto 0) := "0011101";
  constant state48: std_logic_vector(6 downto 0) := "0011001";
  constant state49: std_logic_vector(6 downto 0) := "1101000";
  constant state50: std_logic_vector(6 downto 0) := "0000110";
  constant state51: std_logic_vector(6 downto 0) := "0011000";
  constant state52: std_logic_vector(6 downto 0) := "0110001";
  constant state53: std_logic_vector(6 downto 0) := "0011011";
  constant state54: std_logic_vector(6 downto 0) := "1011100";
  constant state55: std_logic_vector(6 downto 0) := "0100011";
  constant state56: std_logic_vector(6 downto 0) := "1011011";
  constant state57: std_logic_vector(6 downto 0) := "0100100";
  constant state58: std_logic_vector(6 downto 0) := "1011000";
  constant state59: std_logic_vector(6 downto 0) := "0100111";
  constant state60: std_logic_vector(6 downto 0) := "1011001";
  constant state61: std_logic_vector(6 downto 0) := "1100110";
  constant state62: std_logic_vector(6 downto 0) := "0100101";
  constant state63: std_logic_vector(6 downto 0) := "0001100";
  constant state64: std_logic_vector(6 downto 0) := "1100101";
  constant state65: std_logic_vector(6 downto 0) := "1110011";
  constant state66: std_logic_vector(6 downto 0) := "0100010";
  constant state67: std_logic_vector(6 downto 0) := "0001011";
  constant state68: std_logic_vector(6 downto 0) := "0110100";
  constant state69: std_logic_vector(6 downto 0) := "0000010";
  constant state70: std_logic_vector(6 downto 0) := "1010110";
  constant state71: std_logic_vector(6 downto 0) := "1000010";
  constant state72: std_logic_vector(6 downto 0) := "1001001";
  constant state73: std_logic_vector(6 downto 0) := "0010010";
  constant state74: std_logic_vector(6 downto 0) := "0111100";
  constant state75: std_logic_vector(6 downto 0) := "0110010";
  constant state76: std_logic_vector(6 downto 0) := "1000011";
  constant state77: std_logic_vector(6 downto 0) := "1010010";
  constant state78: std_logic_vector(6 downto 0) := "0111101";
  constant state79: std_logic_vector(6 downto 0) := "1110010";
  constant state80: std_logic_vector(6 downto 0) := "1100010";
  constant state81: std_logic_vector(6 downto 0) := "0011100";
  constant state82: std_logic_vector(6 downto 0) := "0100110";
  constant state83: std_logic_vector(6 downto 0) := "1010011";
  constant state84: std_logic_vector(6 downto 0) := "0101000";
  constant state85: std_logic_vector(6 downto 0) := "1010111";
  constant state86: std_logic_vector(6 downto 0) := "1001000";
  constant state87: std_logic_vector(6 downto 0) := "0011111";
  constant state88: std_logic_vector(6 downto 0) := "0011010";
  constant state89: std_logic_vector(6 downto 0) := "0111011";
  constant state90: std_logic_vector(6 downto 0) := "1000100";
  constant state91: std_logic_vector(6 downto 0) := "0111000";
  constant state92: std_logic_vector(6 downto 0) := "1000111";
  constant state93: std_logic_vector(6 downto 0) := "0111001";
  constant state94: std_logic_vector(6 downto 0) := "0011110";
  constant state95: std_logic_vector(6 downto 0) := "1000110";
  constant state96: std_logic_vector(6 downto 0) := "0110110";
  constant state97: std_logic_vector(6 downto 0) := "1111001";
  constant state98: std_logic_vector(6 downto 0) := "0001000";
  constant state99: std_logic_vector(6 downto 0) := "1110111";
  constant state100: std_logic_vector(6 downto 0) := "0001001";
  constant state101: std_logic_vector(6 downto 0) := "1110110";
  constant state102: std_logic_vector(6 downto 0) := "0000111";
  constant state103: std_logic_vector(6 downto 0) := "1111000";
  constant state104: std_logic_vector(6 downto 0) := "0000100";
  constant state105: std_logic_vector(6 downto 0) := "1101011";
  constant state106: std_logic_vector(6 downto 0) := "0000101";
  constant state107: std_logic_vector(6 downto 0) := "1111010";
  constant state108: std_logic_vector(6 downto 0) := "0000011";
  constant state109: std_logic_vector(6 downto 0) := "1111100";
  constant state110: std_logic_vector(6 downto 0) := "0000000";
  constant state111: std_logic_vector(6 downto 0) := "0010100";
  constant state112: std_logic_vector(6 downto 0) := "1111011";
  constant state113: std_logic_vector(6 downto 0) := "0010110";
  constant state114: std_logic_vector(6 downto 0) := "0110111";
  constant state115: std_logic_vector(6 downto 0) := "1001100";
  constant state116: std_logic_vector(6 downto 0) := "0110101";
  constant state117: std_logic_vector(6 downto 0) := "1001110";
  constant state118: std_logic_vector(6 downto 0) := "0110011";
  constant state119: std_logic_vector(6 downto 0) := "1010000";
  constant state120: std_logic_vector(6 downto 0) := "0101110";
  constant state121: std_logic_vector(6 downto 0) := "1001011";
  signal current_state, next_state: std_logic_vector(6 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-------"; output <= "--------------------------------------------------------";
    if std_match(input, "0--------------------------") then next_state <= state1; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
    else
    case current_state is
      when state1 =>
        if std_match(input, "1--------------------------") then next_state <= state3; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state2 =>
        if std_match(input, "1--------------------------") then next_state <= state1; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state3 =>
        if std_match(input, "1--------------------------") then next_state <= state4; output <= "00000010010000001-0000000-00-0001001000010-0-----00-0---";
        end if;
      when state4 =>
        if std_match(input, "1--------------------------") then next_state <= state5; output <= "00000010000000000-0000000-00-0000000110101-0-----00-0---";
        end if;
      when state5 =>
        if std_match(input, "1--------------------------") then next_state <= state7; output <= "00000001000000000-0000000-00-0000000001000-0-----00-0---";
        end if;
      when state6 =>
        if std_match(input, "1--------------------------") then next_state <= state2; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state7 =>
        if std_match(input, "1-----0--------------------") then next_state <= state9; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----1--------------------") then next_state <= state8; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state8 =>
        if std_match(input, "1--------------------------") then next_state <= state17; output <= "00000010000000000-0000000-00-0000000001000-0-----00-0---";
        end if;
      when state9 =>
        if std_match(input, "1----0---------------------") then next_state <= state12; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1----1---------------------") then next_state <= state10; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state10 =>
        if std_match(input, "1--------------------------") then next_state <= state11; output <= "00000010000000000-0000001-00-0000000000001-0-----00-0---";
        end if;
      when state11 =>
        if std_match(input, "1--------------------------") then next_state <= state12; output <= "00000000000000000-0000000-00-0000010000000-0-----00-0---";
        end if;
      when state12 =>
        if std_match(input, "1---0----------------------") then next_state <= state15; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1---1----------------------") then next_state <= state13; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state13 =>
        if std_match(input, "1--------------------------") then next_state <= state29; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state14 =>
        if std_match(input, "1--------------------------") then next_state <= state17; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state15 =>
        if std_match(input, "1--------------------------") then next_state <= state59; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state16 =>
        if std_match(input, "1--------------------------") then next_state <= state17; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state17 =>
        if std_match(input, "1--------------------------") then next_state <= state18; output <= "0000000000010100001000000-10-000000000000011-----00-0---";
        end if;
      when state18 =>
        if std_match(input, "1--------------------------") then next_state <= state19; output <= "00100000000000000-0000000-00-0000000000000-0000--00-0---";
        end if;
      when state19 =>
        if std_match(input, "1--0-----------------------") then next_state <= state21; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1--1-----------------------") then next_state <= state20; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state20 =>
        if std_match(input, "1--------------------------") then next_state <= state21; output <= "00000001000000000-0000000-00-0000000100000-0-----00-0---";
        end if;
      when state21 =>
        if std_match(input, "1--------------------------") then next_state <= state22; output <= "01000000000100000-0000000-10-100000000000000000001001---";
        end if;
      when state22 =>
        if std_match(input, "1--------------------------") then next_state <= state23; output <= "00010000000000000-0000000-00-0000000000000-0000--01-0---";
        end if;
      when state23 =>
        if std_match(input, "1--------------------------") then next_state <= state24; output <= "00000000100000000-0000000-00-0000000000000-0---0000-0---";
        end if;
      when state24 =>
        if std_match(input, "1-0------------------------") then next_state <= state26; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-1------------------------") then next_state <= state25; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state25 =>
        if std_match(input, "1--------------------------") then next_state <= state26; output <= "00000001000000000-0000000-00-0000000010000-0-----00-0---";
        end if;
      when state26 =>
        if std_match(input, "10-------------------------") then next_state <= state28; output <= "00000000010000010-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "11-------------------------") then next_state <= state27; output <= "00000000010000010-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state27 =>
        if std_match(input, "1--------------------------") then next_state <= state28; output <= "00000000000000000-0000000-00-0010000000000-0-----00-0---";
        end if;
      when state28 =>
        if std_match(input, "1--------------------------") then next_state <= state7; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state29 =>
        if std_match(input, "1------1-------------------") then next_state <= state36; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------01------------------") then next_state <= state36; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0011----------------") then next_state <= state36; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0010----------------") then next_state <= state34; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0001----------------") then next_state <= state32; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0000----------------") then next_state <= state30; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state30 =>
        if std_match(input, "1--------------------------") then next_state <= state38; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state31 =>
        if std_match(input, "1--------------------------") then next_state <= state37; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state32 =>
        if std_match(input, "1--------------------------") then next_state <= state55; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state33 =>
        if std_match(input, "1--------------------------") then next_state <= state37; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state34 =>
        if std_match(input, "1--------------------------") then next_state <= state57; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state35 =>
        if std_match(input, "1--------------------------") then next_state <= state37; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state36 =>
        if std_match(input, "1--------------------------") then next_state <= state37; output <= "00000001000000000-0000000-00-0000000010000-0-----00-0---";
        end if;
      when state37 =>
        if std_match(input, "1--------------------------") then next_state <= state14; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state38 =>
        if std_match(input, "1----------1---------------") then next_state <= state43; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1----------01--------------") then next_state <= state43; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1----------001-------------") then next_state <= state43; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1----------0001------------") then next_state <= state41; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1----------0000------------") then next_state <= state39; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state39 =>
        if std_match(input, "1--------------------------") then next_state <= state45; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state40 =>
        if std_match(input, "1--------------------------") then next_state <= state44; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state41 =>
        if std_match(input, "1--------------------------") then next_state <= state50; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state42 =>
        if std_match(input, "1--------------------------") then next_state <= state44; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state43 =>
        if std_match(input, "1--------------------------") then next_state <= state44; output <= "00000001000000000-0000000-00-0000000010000-0-----00-0---";
        end if;
      when state44 =>
        if std_match(input, "1--------------------------") then next_state <= state31; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state45 =>
        if std_match(input, "1--------------0-----------") then next_state <= state48; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1--------------1-----------") then next_state <= state46; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state46 =>
        if std_match(input, "1--------------------------") then next_state <= state47; output <= "0000000001000101001000000-00-0000000000000-0-----00-0---";
        end if;
      when state47 =>
        if std_match(input, "1--------------------------") then next_state <= state49; output <= "00000000000000000-0000000-00-0000100000000-0-----00-0---";
        end if;
      when state48 =>
        if std_match(input, "1--------------------------") then next_state <= state49; output <= "0000000000100000111001010-00-0000000000000-0-----00-0---";
        end if;
      when state49 =>
        if std_match(input, "1--------------------------") then next_state <= state40; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state50 =>
        if std_match(input, "1--------------0-----------") then next_state <= state52; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1--------------1-----------") then next_state <= state51; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state51 =>
        if std_match(input, "1--------------------------") then next_state <= state54; output <= "0000000000100000111001010-00-0000000000000-0-----00-0---";
        end if;
      when state52 =>
        if std_match(input, "1--------------------------") then next_state <= state53; output <= "0000000000000101001000000-00-0000000000000-0-----00-0---";
        end if;
      when state53 =>
        if std_match(input, "1--------------------------") then next_state <= state54; output <= "00000000000000000-0000000-00-0000100000000-0-----00-0---";
        end if;
      when state54 =>
        if std_match(input, "1--------------------------") then next_state <= state42; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state55 =>
        if std_match(input, "1--------------------------") then next_state <= state56; output <= "0000000000100000111001010-00-0000000000000-0-----00-0---";
        end if;
      when state56 =>
        if std_match(input, "1--------------------------") then next_state <= state33; output <= "00000000000000000-0000000-00-0000100000000-0-----00-0---";
        end if;
      when state57 =>
        if std_match(input, "1--------------------------") then next_state <= state58; output <= "00000000001000001-0001000-00-0000000000000-0-----00-0---";
        end if;
      when state58 =>
        if std_match(input, "1--------------------------") then next_state <= state35; output <= "00000000000000000-0000000-00-0000100000000-0-----00-0---";
        end if;
      when state59 =>
        if std_match(input, "1---------------0----------") then next_state <= state67; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1---------------1----------") then next_state <= state60; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state60 =>
        if std_match(input, "1------1-------------------") then next_state <= state67; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------01------------------") then next_state <= state67; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0011----------------") then next_state <= state67; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0010----------------") then next_state <= state65; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0001----------------") then next_state <= state63; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0000----------------") then next_state <= state61; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state61 =>
        if std_match(input, "1--------------------------") then next_state <= state82; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state62 =>
        if std_match(input, "1--------------------------") then next_state <= state67; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state63 =>
        if std_match(input, "1--------------------------") then next_state <= state83; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state64 =>
        if std_match(input, "1--------------------------") then next_state <= state67; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state65 =>
        if std_match(input, "1--------------------------") then next_state <= state89; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state66 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state67 =>
        if std_match(input, "1------1-------------------") then next_state <= state80; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------011-----------------") then next_state <= state80; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0101----------------") then next_state <= state78; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0100----------------") then next_state <= state76; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0011----------------") then next_state <= state74; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0010----------------") then next_state <= state72; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0001----------------") then next_state <= state70; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1------0000----------------") then next_state <= state68; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state68 =>
        if std_match(input, "1--------------------------") then next_state <= state96; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state69 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state70 =>
        if std_match(input, "1--------------------------") then next_state <= state98; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state71 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state72 =>
        if std_match(input, "1--------------------------") then next_state <= state103; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state73 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state74 =>
        if std_match(input, "1--------------------------") then next_state <= state107; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state75 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state76 =>
        if std_match(input, "1--------------------------") then next_state <= state115; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state77 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state78 =>
        if std_match(input, "1--------------------------") then next_state <= state117; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state79 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state80 =>
        if std_match(input, "1--------------------------") then next_state <= state81; output <= "00000001000000000-0000000-00-0000000010000-0-----00-0---";
        end if;
      when state81 =>
        if std_match(input, "1--------------------------") then next_state <= state16; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state82 =>
        if std_match(input, "1--------------------------") then next_state <= state62; output <= "00000001000000000-0000000-00-0000000010000-0-----00-0---";
        end if;
      when state83 =>
        if std_match(input, "1--------------------------") then next_state <= state84; output <= "00000001000000000-0000000-00-0000000001000-0-----00-0---";
        end if;
      when state84 =>
        if std_match(input, "1--------------------------") then next_state <= state86; output <= "00001000000001001-0000000-00-0000000000000-0100--00-0---";
        end if;
      when state85 =>
        if std_match(input, "1--------------------------") then next_state <= state64; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state86 =>
        if std_match(input, "1----------------0---------") then next_state <= state88; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1----------------1---------") then next_state <= state87; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state87 =>
        if std_match(input, "1--------------------------") then next_state <= state16; output <= "00000001000000000-0000000-00-0000100001000-0-----00-0---";
        end if;
      when state88 =>
        if std_match(input, "1--------------------------") then next_state <= state86; output <= "00000000000000000-0000000-00-0000100000000-0-----00-0---";
        end if;
      when state89 =>
        if std_match(input, "1--------------------------") then next_state <= state91; output <= "00001001000000000-0000000-00-0001000001000-0-----00-0---";
        end if;
      when state90 =>
        if std_match(input, "1--------------------------") then next_state <= state66; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state91 =>
        if std_match(input, "1--------------------------") then next_state <= state92; output <= "00000010000000000-0000000-00-0000000000000-0010--00-0---";
        end if;
      when state92 =>
        if std_match(input, "1--0-----------------------") then next_state <= state95; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1--1-----------------------") then next_state <= state93; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state93 =>
        if std_match(input, "1--------------------------") then next_state <= state94; output <= "00000000000100001-0000000-10-0000000000000-0-----00-0---";
        end if;
      when state94 =>
        if std_match(input, "1--------------------------") then next_state <= state16; output <= "00000000000000000-0000000-00-0000100000000-0-----00-0---";
        end if;
      when state95 =>
        if std_match(input, "1--------------------------") then next_state <= state91; output <= "00000000000000000-0000000-00-0010100000000-0-----00-0---";
        end if;
      when state96 =>
        if std_match(input, "1--------------------------") then next_state <= state97; output <= "00000100000001000-0000000-00-000000000000011101111011101";
        end if;
      when state97 =>
        if std_match(input, "1--------------------------") then next_state <= state69; output <= "001000010000000100101010010110100000000001-0-----00-0---";
        end if;
      when state98 =>
        if std_match(input, "1--------------0-----------") then next_state <= state101; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1--------------1-----------") then next_state <= state99; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state99 =>
        if std_match(input, "1--------------------------") then next_state <= state100; output <= "00000100000001000-0000000-00-000000000000011101111011101";
        end if;
      when state100 =>
        if std_match(input, "1--------------------------") then next_state <= state102; output <= "001000010000000100101010010110100000000001-0-----00-0---";
        end if;
      when state101 =>
        if std_match(input, "1--------------------------") then next_state <= state102; output <= "00000100000001001-0000000-00-0000000001000-0100--00-0---";
        end if;
      when state102 =>
        if std_match(input, "1--------------------------") then next_state <= state71; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state103 =>
        if std_match(input, "1--------------0-----------") then next_state <= state105; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1--------------1-----------") then next_state <= state104; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state104 =>
        if std_match(input, "1--------------------------") then next_state <= state106; output <= "0000000000000101001000000-00-0000000000000-0-----00-0---";
        end if;
      when state105 =>
        if std_match(input, "1--------------------------") then next_state <= state106; output <= "00000100000001001-0000000-00-0000000001000-0100--00-0---";
        end if;
      when state106 =>
        if std_match(input, "1--------------------------") then next_state <= state73; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state107 =>
        if std_match(input, "1--------------0-----------") then next_state <= state112; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1--------------1-----------") then next_state <= state108; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state108 =>
        if std_match(input, "1-----------------00000000-") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------1--------") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------01-------") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------001------") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------0001-----") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------00001----") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------000001---") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------0000001--") then next_state <= state110; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-----------------00000001-") then next_state <= state109; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state109 =>
        if std_match(input, "1--------------------------") then next_state <= state112; output <= "0000000000001100101000000-00-0000000000000-0-----00-0100";
        end if;
      when state110 =>
        if std_match(input, "1--------------------------") then next_state <= state111; output <= "0000010000000101001010000-0000100000000000111000110-0100";
        end if;
      when state111 =>
        if std_match(input, "1--------------------------") then next_state <= state114; output <= "00000001000000000-0000100001-0000000000001-0-----00-0---";
        end if;
      when state112 =>
        if std_match(input, "1--------------------------") then next_state <= state113; output <= "00000100000001001-0000000-00-0000000000000-0100--00-0---";
        end if;
      when state113 =>
        if std_match(input, "1--------------------------") then next_state <= state114; output <= "00000001000000000-0000000-00-0000000001000-0-----00-0---";
        end if;
      when state114 =>
        if std_match(input, "1--------------------------") then next_state <= state75; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state115 =>
        if std_match(input, "1--------------------------") then next_state <= state116; output <= "00001000000010001-0010000-00-0000000000000-01011010-0101";
        end if;
      when state116 =>
        if std_match(input, "1--------------------------") then next_state <= state77; output <= "10000001000000000-0000100-00-0001000001101-0-----00-0---";
        end if;
      when state117 =>
        if std_match(input, "1--------------------------") then next_state <= state118; output <= "00000010000000000-0000000-00-0000000000000-0-----00-0011";
        end if;
      when state118 =>
        if std_match(input, "1-------------------------0") then next_state <= state121; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        elsif std_match(input, "1-------------------------1") then next_state <= state119; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when state119 =>
        if std_match(input, "1--------------------------") then next_state <= state120; output <= "0000010000001000001000000-00-0000000000000111011010-0101";
        end if;
      when state120 =>
        if std_match(input, "1--------------------------") then next_state <= state16; output <= "00010010000000010-000000000110100000000100-0-----00-0---";
        end if;
      when state121 =>
        if std_match(input, "1--------------------------") then next_state <= state79; output <= "00000000000000000-0000000-00-0000000000000-0-----00-0---";
        end if;
      when others => next_state <= "-------"; output <= "--------------------------------------------------------";
    end case;
    end if;
  end process;
end behaviour;
