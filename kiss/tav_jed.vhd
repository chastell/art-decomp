library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity tav_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(3 downto 0);
    output: out std_logic_vector(3 downto 0)
  );
end tav_jed;
architecture behaviour of tav_jed is
  constant st0: std_logic_vector(1 downto 0) := "11";
  constant st1: std_logic_vector(1 downto 0) := "00";
  constant st2: std_logic_vector(1 downto 0) := "01";
  constant st3: std_logic_vector(1 downto 0) := "10";
  signal current_state, next_state: std_logic_vector(1 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "--"; output <= "----";
    case current_state is
      when st0 =>
        if std_match(input, "1000") then next_state <= st1; output <= "1000";
        elsif std_match(input, "0100") then next_state <= st1; output <= "0100";
        elsif std_match(input, "0010") then next_state <= st1; output <= "0010";
        elsif std_match(input, "0001") then next_state <= st1; output <= "0001";
        elsif std_match(input, "0000") then next_state <= st1; output <= "0000";
        elsif std_match(input, "11--") then next_state <= st1; output <= "0000";
        elsif std_match(input, "1-1-") then next_state <= st1; output <= "0000";
        elsif std_match(input, "1--1") then next_state <= st1; output <= "0000";
        elsif std_match(input, "-11-") then next_state <= st1; output <= "0000";
        elsif std_match(input, "-1-1") then next_state <= st1; output <= "0000";
        elsif std_match(input, "--11") then next_state <= st1; output <= "0000";
        end if;
      when st1 =>
        if std_match(input, "1000") then next_state <= st2; output <= "1000";
        elsif std_match(input, "0100") then next_state <= st2; output <= "0100";
        elsif std_match(input, "0010") then next_state <= st2; output <= "0010";
        elsif std_match(input, "0001") then next_state <= st2; output <= "0001";
        elsif std_match(input, "1100") then next_state <= st2; output <= "1100";
        elsif std_match(input, "1010") then next_state <= st2; output <= "1010";
        elsif std_match(input, "1001") then next_state <= st2; output <= "1001";
        elsif std_match(input, "0110") then next_state <= st2; output <= "0000";
        elsif std_match(input, "0000") then next_state <= st2; output <= "0000";
        elsif std_match(input, "0011") then next_state <= st2; output <= "0011";
        elsif std_match(input, "0101") then next_state <= st2; output <= "0101";
        elsif std_match(input, "0111") then next_state <= st2; output <= "0001";
        elsif std_match(input, "1011") then next_state <= st2; output <= "1011";
        elsif std_match(input, "1101") then next_state <= st2; output <= "1101";
        elsif std_match(input, "1110") then next_state <= st2; output <= "1000";
        elsif std_match(input, "1111") then next_state <= st2; output <= "1001";
        end if;
      when st2 =>
        if std_match(input, "1000") then next_state <= st3; output <= "1000";
        elsif std_match(input, "0100") then next_state <= st3; output <= "0100";
        elsif std_match(input, "0010") then next_state <= st3; output <= "0010";
        elsif std_match(input, "0001") then next_state <= st3; output <= "0001";
        elsif std_match(input, "0000") then next_state <= st3; output <= "0000";
        elsif std_match(input, "11--") then next_state <= st3; output <= "0000";
        elsif std_match(input, "1-1-") then next_state <= st3; output <= "0000";
        elsif std_match(input, "1--1") then next_state <= st3; output <= "0000";
        elsif std_match(input, "-11-") then next_state <= st3; output <= "0000";
        elsif std_match(input, "-1-1") then next_state <= st3; output <= "0000";
        elsif std_match(input, "--11") then next_state <= st3; output <= "0000";
        end if;
      when st3 =>
        if std_match(input, "1000") then next_state <= st0; output <= "1000";
        elsif std_match(input, "0100") then next_state <= st0; output <= "0100";
        elsif std_match(input, "0010") then next_state <= st0; output <= "0010";
        elsif std_match(input, "0001") then next_state <= st0; output <= "0001";
        elsif std_match(input, "0000") then next_state <= st0; output <= "0000";
        elsif std_match(input, "11--") then next_state <= st0; output <= "0000";
        elsif std_match(input, "1-1-") then next_state <= st0; output <= "0000";
        elsif std_match(input, "1--1") then next_state <= st0; output <= "0000";
        elsif std_match(input, "-11-") then next_state <= st0; output <= "0000";
        elsif std_match(input, "-1-1") then next_state <= st0; output <= "0000";
        elsif std_match(input, "--11") then next_state <= st0; output <= "0000";
        end if;
      when others => next_state <= "--"; output <= "----";
    end case;
  end process;
end behaviour;
