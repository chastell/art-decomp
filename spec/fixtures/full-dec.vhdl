library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity full_4 is
  port(
        reset: in  std_logic;
        clock: in  std_logic;
        fsm_i: in  std_logic_vector(0 to 3);
        fsm_o: out std_logic_vector(0 to 1)
      );
end full_4;

architecture behaviour of full_4 is

  signal fsm_q, fsm_qp: std_logic_vector(0 to 5);

  signal d0_x:   std_logic_vector(0 to 3);
  signal d0_q:   std_logic_vector(0 to 5);
  signal d0_qu:  std_logic_vector(0 to 3);
  signal d0_qv:  std_logic_vector(0 to 1);
  signal d0_g_i: std_logic_vector(0 to 4);
  signal d0_g_o: std_logic_vector(0 to 1);

  signal d1_x:   std_logic_vector(0 to 2);
  signal d1_q:   std_logic_vector(0 to 3);
  signal d1_qu:  std_logic_vector(0 to 1);
  signal d1_qv:  std_logic_vector(0 to 1);
  signal d1_g_i: std_logic_vector(0 to 3);
  signal d1_g_o: std_logic_vector(0 to 1);

  signal d1_h_i: std_logic_vector(0 to 4);
  signal d1_h_o: std_logic_vector(0 to 7);

begin

  d0_x   <= fsm_i;
  d0_q   <= fsm_q;

  d0_qu  <= d0_q(0 to 3);
  d0_qv  <= d0_q(4 to 5);

  d0_g_i <= (d0_x(0) & d0_x(1) & d0_x(3) & d0_qv);

  d1_x   <= (d0_x(2) & d0_g_o(0) & d0_g_o(1));
  d1_q   <= d0_qu;

  d1_qu  <= d1_q(0 to 1);
  d1_qv  <= d1_q(2 to 3);

  d1_g_i <= (d1_x(1) & d1_x(2) & d1_qv);

  d1_h_i <= (d1_x(0) & d1_g_o & d1_qu);

  fsm_qp <= d1_h_o(0 to 5);
  fsm_o  <= d1_h_o(6 to 7);

  process(reset, clock) begin
    if reset = '1' then fsm_q <= "110110";
    elsif rising_edge(clock) then fsm_q <= fsm_qp;
    end if;
  end process;

  d0_g: process(d0_g_i) begin
    d0_g_o <= (others => '-');
    if    std_match(d0_g_i, "-0-10") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "-1001") then d0_g_o <= "00";
    elsif std_match(d0_g_i, "-1101") then d0_g_o <= "10";
    elsif std_match(d0_g_i, "-1110") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "0000-") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "00101") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "010-0") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "01100") then d0_g_o <= "01";
    elsif std_match(d0_g_i, "10-01") then d0_g_o <= "01";
    elsif std_match(d0_g_i, "10100") then d0_g_o <= "11";
    elsif std_match(d0_g_i, "11000") then d0_g_o <= "01";
    elsif std_match(d0_g_i, "11010") then d0_g_o <= "11";
    end if;
  end process;

  d1_g: process(d1_g_i) begin
    d1_g_o <= (others => '-');
    if    std_match(d1_g_i, "0000") then d1_g_o <= "10";
    elsif std_match(d1_g_i, "0100") then d1_g_o <= "11";
    elsif std_match(d1_g_i, "0110") then d1_g_o <= "10";
    elsif std_match(d1_g_i, "1000") then d1_g_o <= "00";
    elsif std_match(d1_g_i, "1100") then d1_g_o <= "01";
    elsif std_match(d1_g_i, "1101") then d1_g_o <= "10";
    elsif std_match(d1_g_i, "1110") then d1_g_o <= "11";
    end if;
  end process;

  d1_h: process(d1_h_i) begin
    d1_h_o <= (others => '-');
    if    std_match(d1_h_i, "00010") then d1_h_o <= "01100000";
    elsif std_match(d1_h_i, "00110") then d1_h_o <= "10000101";
    elsif std_match(d1_h_i, "01000") then d1_h_o <= "00010111";
    elsif std_match(d1_h_i, "01001") then d1_h_o <= "01100000";
    elsif std_match(d1_h_i, "01010") then d1_h_o <= "11100011";
    elsif std_match(d1_h_i, "01011") then d1_h_o <= "11011000";
    elsif std_match(d1_h_i, "01101") then d1_h_o <= "11100001";
    elsif std_match(d1_h_i, "01110") then d1_h_o <= "11011001";
    elsif std_match(d1_h_i, "01111") then d1_h_o <= "10000101";
    elsif std_match(d1_h_i, "1-110") then d1_h_o <= "11101001";
    elsif std_match(d1_h_i, "10010") then d1_h_o <= "01100011";
    elsif std_match(d1_h_i, "11-11") then d1_h_o <= "11101010";
    elsif std_match(d1_h_i, "11000") then d1_h_o <= "10000101";
    elsif std_match(d1_h_i, "11001") then d1_h_o <= "00010100";
    elsif std_match(d1_h_i, "11010") then d1_h_o <= "00010100";
    elsif std_match(d1_h_i, "11101") then d1_h_o <= "01100011";
    end if;
  end process;

end behaviour;
