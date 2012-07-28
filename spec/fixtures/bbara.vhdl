-- 11 cells of target arch (6/1 + 5/2)
-- G archs: 5/2 5/4
-- H arch: 6/8

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity bbara is
  port(
        reset: in  std_logic;
        clock: in  std_logic;
        fsm_i: in  std_logic_vector(0 to 3);
        fsm_o: out std_logic_vector(0 to 1)
      );
end bbara;

architecture behaviour of bbara is

  signal fsm_q, fsm_qp: std_logic_vector(0 to 5);

  signal d0_x:   std_logic_vector(0 to 3);
  signal d0_q:   std_logic_vector(0 to 5);
  signal d0_qu:  std_logic_vector(0 to 3);
  signal d0_qv:  std_logic_vector(0 to 1);
  signal d0_g_i: std_logic_vector(0 to 4);
  signal d0_g_o: std_logic_vector(0 to 1);
  signal d1_x:   std_logic_vector(0 to 2);
  signal d1_q:   std_logic_vector(0 to 3);
  signal d1_qu:  std_logic_vector(0 to 0);
  signal d1_qv:  std_logic_vector(0 to 2);
  signal d1_g_i: std_logic_vector(0 to 4);
  signal d1_g_o: std_logic_vector(0 to 3);

  signal d1_h_i: std_logic_vector(0 to 5);
  signal d1_h_o: std_logic_vector(0 to 7);

begin

  d0_x   <= fsm_i;
  d0_q   <= fsm_q;
  d0_qu  <= d0_q(0 to 3);
  d0_qv  <= d0_q(4 to 5);
  d0_g_i <= (d0_x(0) & d0_x(1) & d0_x(3) & d0_qv);
  d1_x   <= (d0_x(2) & d0_g_o);
  d1_q   <= d0_qu;
  d1_qu  <= d1_q(0 to 0);
  d1_qv  <= d1_q(1 to 3);
  d1_g_i <= (d1_x(0) & d1_x(1) & d1_qv);

  d1_h_i <= (d1_x(2) & d1_g_o & d1_qu);

  fsm_qp <= d1_h_o(0 to 5);
  fsm_o  <= d1_h_o(6 to 7);

  process(reset, clock) begin
    if reset = '1' then fsm_q <= "000000";
    elsif rising_edge(clock) then fsm_q <= fsm_qp;
    end if;
  end process;

  d0_g: process(d0_g_i) begin
    d0_g_o <= (others => '-');
    if std_match(d0_g_i, "00000") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "00001") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "00010") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "00011") then d0_g_o <= "01";
    elsif std_match(d0_g_i, "00100") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "00101") then d0_g_o <= "00";
    elsif std_match(d0_g_i, "00110") then d0_g_o <= "00";
    elsif std_match(d0_g_i, "00111") then d0_g_o <= "00";
    elsif std_match(d0_g_i, "01000") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "01001") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "01010") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "01011") then d0_g_o <= "01";
    elsif std_match(d0_g_i, "01100") then d0_g_o <= "10";
    elsif std_match(d0_g_i, "01101") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "01110") then d0_g_o <= "10";
    elsif std_match(d0_g_i, "01111") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "10000") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "10001") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "10010") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "10011") then d0_g_o <= "01";
    elsif std_match(d0_g_i, "10100") then d0_g_o <= "00";
    elsif std_match(d0_g_i, "10101") then d0_g_o <= "10";
    elsif std_match(d0_g_i, "10110") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "10111") then d0_g_o <= "10";
    elsif std_match(d0_g_i, "11000") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "11001") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "11010") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "11011") then d0_g_o <= "01";
    elsif std_match(d0_g_i, "11100") then d0_g_o <= "10";
    elsif std_match(d0_g_i, "11101") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "11110") then d0_g_o <= "10";
    elsif std_match(d0_g_i, "11111") then d0_g_o <= "11";
    end if;
  end process;
  d1_g: process(d1_g_i) begin
    d1_g_o <= (others => '-');
    if std_match(d1_g_i, "00000") then d1_g_o <= "0100";
    elsif std_match(d1_g_i, "00001") then d1_g_o <= "0000";
    elsif std_match(d1_g_i, "00010") then d1_g_o <= "0001";
    elsif std_match(d1_g_i, "00011") then d1_g_o <= "0101";
    elsif std_match(d1_g_i, "00100") then d1_g_o <= "0010";
    elsif std_match(d1_g_i, "00101") then d1_g_o <= "0011";
    elsif std_match(d1_g_i, "01000") then d1_g_o <= "0100";
    elsif std_match(d1_g_i, "01001") then d1_g_o <= "0000";
    elsif std_match(d1_g_i, "01010") then d1_g_o <= "0001";
    elsif std_match(d1_g_i, "01011") then d1_g_o <= "0101";
    elsif std_match(d1_g_i, "01100") then d1_g_o <= "0010";
    elsif std_match(d1_g_i, "01101") then d1_g_o <= "0011";
    elsif std_match(d1_g_i, "10000") then d1_g_o <= "0110";
    elsif std_match(d1_g_i, "10001") then d1_g_o <= "0111";
    elsif std_match(d1_g_i, "10010") then d1_g_o <= "1000";
    elsif std_match(d1_g_i, "10011") then d1_g_o <= "1001";
    elsif std_match(d1_g_i, "10100") then d1_g_o <= "1010";
    elsif std_match(d1_g_i, "10101") then d1_g_o <= "1011";
    elsif std_match(d1_g_i, "11000") then d1_g_o <= "1100";
    elsif std_match(d1_g_i, "11001") then d1_g_o <= "1101";
    elsif std_match(d1_g_i, "11010") then d1_g_o <= "1110";
    elsif std_match(d1_g_i, "11011") then d1_g_o <= "1111";
    elsif std_match(d1_g_i, "11100") then d1_g_o <= "1111";
    elsif std_match(d1_g_i, "11101") then d1_g_o <= "1111";
    end if;
  end process;

  d1_h: process(d1_h_i) begin
    d1_h_o <= (others => '-');
    if std_match(d1_h_i, "-00000") then d1_h_o <= "00011100";
    elsif std_match(d1_h_i, "-00001") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "-00010") then d1_h_o <= "00101100";
    elsif std_match(d1_h_i, "-00011") then d1_h_o <= "10101100";
    elsif std_match(d1_h_i, "-00101") then d1_h_o <= "11001100";
    elsif std_match(d1_h_i, "-00111") then d1_h_o <= "11011100";
    elsif std_match(d1_h_i, "-01011") then d1_h_o <= "10111100";
    elsif std_match(d1_h_i, "001000") then d1_h_o <= "00000000";
    elsif std_match(d1_h_i, "001001") then d1_h_o <= "10000110";
    elsif std_match(d1_h_i, "001010") then d1_h_o <= "00111001";
    elsif std_match(d1_h_i, "001100") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "001101") then d1_h_o <= "10111100";
    elsif std_match(d1_h_i, "001110") then d1_h_o <= "00000000";
    elsif std_match(d1_h_i, "001111") then d1_h_o <= "00000000";
    elsif std_match(d1_h_i, "010000") then d1_h_o <= "00011100";
    elsif std_match(d1_h_i, "010001") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "010010") then d1_h_o <= "10111100";
    elsif std_match(d1_h_i, "010011") then d1_h_o <= "11001100";
    elsif std_match(d1_h_i, "010101") then d1_h_o <= "11011100";
    elsif std_match(d1_h_i, "010111") then d1_h_o <= "00000000";
    elsif std_match(d1_h_i, "011000") then d1_h_o <= "00011100";
    elsif std_match(d1_h_i, "011001") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "011010") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "011011") then d1_h_o <= "10101100";
    elsif std_match(d1_h_i, "011100") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "011101") then d1_h_o <= "00111000";
    elsif std_match(d1_h_i, "011110") then d1_h_o <= "00011100";
    elsif std_match(d1_h_i, "011111") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "101000") then d1_h_o <= "00000000";
    elsif std_match(d1_h_i, "101001") then d1_h_o <= "10000110";
    elsif std_match(d1_h_i, "101010") then d1_h_o <= "00111001";
    elsif std_match(d1_h_i, "101110") then d1_h_o <= "00011100";
    elsif std_match(d1_h_i, "101111") then d1_h_o <= "10011100";
    elsif std_match(d1_h_i, "110000") then d1_h_o <= "00101100";
    elsif std_match(d1_h_i, "110001") then d1_h_o <= "10101100";
    elsif std_match(d1_h_i, "110011") then d1_h_o <= "10111100";
    elsif std_match(d1_h_i, "110101") then d1_h_o <= "11001100";
    elsif std_match(d1_h_i, "110111") then d1_h_o <= "11011100";
    elsif std_match(d1_h_i, "111000") then d1_h_o <= "00000000";
    elsif std_match(d1_h_i, "111001") then d1_h_o <= "10000110";
    elsif std_match(d1_h_i, "111010") then d1_h_o <= "00101100";
    elsif std_match(d1_h_i, "111011") then d1_h_o <= "00011100";
    elsif std_match(d1_h_i, "111100") then d1_h_o <= "10000100";
    elsif std_match(d1_h_i, "111101") then d1_h_o <= "00011100";
    elsif std_match(d1_h_i, "111110") then d1_h_o <= "00111001";
    elsif std_match(d1_h_i, "111111") then d1_h_o <= "00011100";
    end if;
  end process;

end behaviour;
