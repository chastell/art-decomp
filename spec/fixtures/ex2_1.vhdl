-- 12 cells of target arch (6/1 + 5/2)
-- G archs: 6/5
-- H arch: 6/7

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ex2_1 is
  port(
        reset: in  std_logic;
        clock: in  std_logic;
        fsm_i: in  std_logic_vector(0 to 1);
        fsm_o: out std_logic_vector(0 to 1)
      );
end ex2_1;

architecture behaviour of ex2_1 is

  signal fsm_q, fsm_qp: std_logic_vector(0 to 4);

  signal d0_x:   std_logic_vector(0 to 1);
  signal d0_q:   std_logic_vector(0 to 4);
  signal d0_qu:  std_logic_vector(0 to -1);
  signal d0_qv:  std_logic_vector(0 to 4);
  signal d0_g_i: std_logic_vector(0 to 5);
  signal d0_g_o: std_logic_vector(0 to 4);

  signal d0_h_i: std_logic_vector(0 to 5);
  signal d0_h_o: std_logic_vector(0 to 6);

begin

  d0_x   <= fsm_i;
  d0_q   <= fsm_q;

  d0_qu  <= d0_q(0 to -1);
  d0_qv  <= d0_q(0 to 4);

  d0_g_i <= (d0_x(1) & d0_qv);

  d0_h_i <= (d0_x(0) & d0_g_o & d0_qu);

  fsm_qp <= d0_h_o(0 to 4);
  fsm_o  <= d0_h_o(5 to 6);

  process(reset, clock) begin
    if reset = '1' then fsm_q <= "00000";
    elsif rising_edge(clock) then fsm_q <= fsm_qp;
    end if;
  end process;

  d0_g: process(d0_g_i) begin
    d0_g_o <= (others => '-');
    if    std_match(d0_g_i, "000000") then d0_g_o <= "01001";
    elsif std_match(d0_g_i, "000001") then d0_g_o <= "00001";
    elsif std_match(d0_g_i, "000010") then d0_g_o <= "00011";
    elsif std_match(d0_g_i, "000011") then d0_g_o <= "00101";
    elsif std_match(d0_g_i, "000100") then d0_g_o <= "10110";
    elsif std_match(d0_g_i, "000101") then d0_g_o <= "01000";
    elsif std_match(d0_g_i, "000110") then d0_g_o <= "01011";
    elsif std_match(d0_g_i, "000111") then d0_g_o <= "01011";
    elsif std_match(d0_g_i, "001000") then d0_g_o <= "01011";
    elsif std_match(d0_g_i, "001001") then d0_g_o <= "10111";
    elsif std_match(d0_g_i, "001010") then d0_g_o <= "01110";
    elsif std_match(d0_g_i, "001011") then d0_g_o <= "10000";
    elsif std_match(d0_g_i, "001100") then d0_g_o <= "10010";
    elsif std_match(d0_g_i, "001101") then d0_g_o <= "10110";
    elsif std_match(d0_g_i, "001110") then d0_g_o <= "10101";
    elsif std_match(d0_g_i, "001111") then d0_g_o <= "11001";
    elsif std_match(d0_g_i, "010000") then d0_g_o <= "11001";
    elsif std_match(d0_g_i, "010001") then d0_g_o <= "11001";
    elsif std_match(d0_g_i, "100000") then d0_g_o <= "00000";
    elsif std_match(d0_g_i, "100001") then d0_g_o <= "00010";
    elsif std_match(d0_g_i, "100010") then d0_g_o <= "00100";
    elsif std_match(d0_g_i, "100011") then d0_g_o <= "00110";
    elsif std_match(d0_g_i, "100100") then d0_g_o <= "00111";
    elsif std_match(d0_g_i, "100101") then d0_g_o <= "10110";
    elsif std_match(d0_g_i, "100110") then d0_g_o <= "01001";
    elsif std_match(d0_g_i, "100111") then d0_g_o <= "01010";
    elsif std_match(d0_g_i, "101000") then d0_g_o <= "01100";
    elsif std_match(d0_g_i, "101001") then d0_g_o <= "01101";
    elsif std_match(d0_g_i, "101010") then d0_g_o <= "01111";
    elsif std_match(d0_g_i, "101011") then d0_g_o <= "10001";
    elsif std_match(d0_g_i, "101100") then d0_g_o <= "10011";
    elsif std_match(d0_g_i, "101101") then d0_g_o <= "10100";
    elsif std_match(d0_g_i, "101110") then d0_g_o <= "10110";
    elsif std_match(d0_g_i, "101111") then d0_g_o <= "10111";
    elsif std_match(d0_g_i, "110000") then d0_g_o <= "11000";
    elsif std_match(d0_g_i, "110001") then d0_g_o <= "11010";
    end if;
  end process;

  d0_h: process(d0_h_i) begin
    d0_h_o <= (others => '-');
    if    std_match(d0_h_i, "000000") then d0_h_o <= "00011--";
    elsif std_match(d0_h_i, "000001") then d0_h_o <= "00101--";
    elsif std_match(d0_h_i, "000010") then d0_h_o <= "01000--";
    elsif std_match(d0_h_i, "000101") then d0_h_o <= "00001--";
    elsif std_match(d0_h_i, "000110") then d0_h_o <= "00000--";
    elsif std_match(d0_h_i, "001000") then d0_h_o <= "0000000";
    elsif std_match(d0_h_i, "001001") then d0_h_o <= "0000100";
    elsif std_match(d0_h_i, "001011") then d0_h_o <= "0010011";
    elsif std_match(d0_h_i, "001100") then d0_h_o <= "0001011";
    elsif std_match(d0_h_i, "001101") then d0_h_o <= "01100--";
    elsif std_match(d0_h_i, "001110") then d0_h_o <= "01110--";
    elsif std_match(d0_h_i, "001111") then d0_h_o <= "10001--";
    elsif std_match(d0_h_i, "010010") then d0_h_o <= "01010--";
    elsif std_match(d0_h_i, "010011") then d0_h_o <= "0100100";
    elsif std_match(d0_h_i, "010101") then d0_h_o <= "0100100";
    elsif std_match(d0_h_i, "010111") then d0_h_o <= "01010--";
    elsif std_match(d0_h_i, "011001") then d0_h_o <= "0110111";
    elsif std_match(d0_h_i, "011010") then d0_h_o <= "01011--";
    elsif std_match(d0_h_i, "100000") then d0_h_o <= "00010--";
    elsif std_match(d0_h_i, "100010") then d0_h_o <= "-----11";
    elsif std_match(d0_h_i, "100011") then d0_h_o <= "00110--";
    elsif std_match(d0_h_i, "100100") then d0_h_o <= "00111--";
    elsif std_match(d0_h_i, "100101") then d0_h_o <= "00101--";
    elsif std_match(d0_h_i, "100110") then d0_h_o <= "00100--";
    elsif std_match(d0_h_i, "100111") then d0_h_o <= "00101--";
    elsif std_match(d0_h_i, "101000") then d0_h_o <= "00001--";
    elsif std_match(d0_h_i, "101010") then d0_h_o <= "0000000";
    elsif std_match(d0_h_i, "101101") then d0_h_o <= "01011--";
    elsif std_match(d0_h_i, "110000") then d0_h_o <= "01111--";
    elsif std_match(d0_h_i, "110001") then d0_h_o <= "10000--";
    elsif std_match(d0_h_i, "110010") then d0_h_o <= "01110--";
    elsif std_match(d0_h_i, "110011") then d0_h_o <= "01101--";
    elsif std_match(d0_h_i, "110100") then d0_h_o <= "01110--";
    elsif std_match(d0_h_i, "110101") then d0_h_o <= "01010--";
    elsif std_match(d0_h_i, "110110") then d0_h_o <= "-----11";
    elsif std_match(d0_h_i, "111000") then d0_h_o <= "0100100";
    elsif std_match(d0_h_i, "111001") then d0_h_o <= "-----11";
    end if;
  end process;

end behaviour;
