library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity lion_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(0 downto 0)
  );
end lion_jed;
architecture behaviour of lion_jed is
  constant st0: std_logic_vector(1 downto 0) := "10";
  constant st1: std_logic_vector(1 downto 0) := "00";
  constant st2: std_logic_vector(1 downto 0) := "11";
  constant st3: std_logic_vector(1 downto 0) := "01";
  signal current_state, next_state: std_logic_vector(1 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "--"; output <= "-";
    case current_state is
      when st0 =>
        if std_match(input, "-0") then next_state <= st0; output <= "0";
        elsif std_match(input, "11") then next_state <= st0; output <= "0";
        elsif std_match(input, "01") then next_state <= st1; output <= "-";
        end if;
      when st1 =>
        if std_match(input, "0-") then next_state <= st1; output <= "1";
        elsif std_match(input, "11") then next_state <= st0; output <= "0";
        elsif std_match(input, "10") then next_state <= st2; output <= "1";
        end if;
      when st2 =>
        if std_match(input, "1-") then next_state <= st2; output <= "1";
        elsif std_match(input, "00") then next_state <= st1; output <= "1";
        elsif std_match(input, "01") then next_state <= st3; output <= "1";
        end if;
      when st3 =>
        if std_match(input, "0-") then next_state <= st3; output <= "1";
        elsif std_match(input, "11") then next_state <= st2; output <= "1";
        end if;
      when others => next_state <= "--"; output <= "-";
    end case;
  end process;
end behaviour;
