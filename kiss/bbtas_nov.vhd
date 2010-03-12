library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity bbtas_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end bbtas_nov;
architecture behaviour of bbtas_nov is
  constant st0: std_logic_vector(2 downto 0) := "011";
  constant st1: std_logic_vector(2 downto 0) := "000";
  constant st2: std_logic_vector(2 downto 0) := "101";
  constant st3: std_logic_vector(2 downto 0) := "110";
  constant st4: std_logic_vector(2 downto 0) := "001";
  constant st5: std_logic_vector(2 downto 0) := "010";
  signal current_state, next_state: std_logic_vector(2 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---"; output <= "--";
    case current_state is
      when st0 =>
        if std_match(input, "00") then next_state <= st0; output <= "00";
        elsif std_match(input, "01") then next_state <= st1; output <= "00";
        elsif std_match(input, "10") then next_state <= st1; output <= "00";
        elsif std_match(input, "11") then next_state <= st1; output <= "00";
        end if;
      when st1 =>
        if std_match(input, "00") then next_state <= st0; output <= "00";
        elsif std_match(input, "01") then next_state <= st2; output <= "00";
        elsif std_match(input, "10") then next_state <= st2; output <= "00";
        elsif std_match(input, "11") then next_state <= st2; output <= "00";
        end if;
      when st2 =>
        if std_match(input, "00") then next_state <= st1; output <= "00";
        elsif std_match(input, "01") then next_state <= st3; output <= "00";
        elsif std_match(input, "10") then next_state <= st3; output <= "00";
        elsif std_match(input, "11") then next_state <= st3; output <= "00";
        end if;
      when st3 =>
        if std_match(input, "00") then next_state <= st4; output <= "00";
        elsif std_match(input, "01") then next_state <= st3; output <= "01";
        elsif std_match(input, "10") then next_state <= st3; output <= "10";
        elsif std_match(input, "11") then next_state <= st3; output <= "11";
        end if;
      when st4 =>
        if std_match(input, "00") then next_state <= st5; output <= "00";
        elsif std_match(input, "01") then next_state <= st4; output <= "00";
        elsif std_match(input, "10") then next_state <= st4; output <= "00";
        elsif std_match(input, "11") then next_state <= st4; output <= "00";
        end if;
      when st5 =>
        if std_match(input, "00") then next_state <= st0; output <= "00";
        elsif std_match(input, "01") then next_state <= st5; output <= "00";
        elsif std_match(input, "10") then next_state <= st5; output <= "00";
        elsif std_match(input, "11") then next_state <= st5; output <= "00";
        end if;
      when others => next_state <= "---"; output <= "--";
    end case;
  end process;
end behaviour;
