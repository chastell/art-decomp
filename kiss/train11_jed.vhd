library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity train11_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(0 downto 0)
  );
end train11_jed;
architecture behaviour of train11_jed is
  constant st0: std_logic_vector(3 downto 0) := "1110";
  constant st1: std_logic_vector(3 downto 0) := "0110";
  constant st2: std_logic_vector(3 downto 0) := "1011";
  constant st3: std_logic_vector(3 downto 0) := "1100";
  constant st5: std_logic_vector(3 downto 0) := "0010";
  constant st7: std_logic_vector(3 downto 0) := "1111";
  constant st9: std_logic_vector(3 downto 0) := "0011";
  constant st4: std_logic_vector(3 downto 0) := "1000";
  constant st6: std_logic_vector(3 downto 0) := "1010";
  constant st8: std_logic_vector(3 downto 0) := "0111";
  constant st10: std_logic_vector(3 downto 0) := "0100";
  signal current_state, next_state: std_logic_vector(3 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "----"; output <= "-";
    case current_state is
      when st0 =>
        if std_match(input, "00") then next_state <= st0; output <= "0";
        elsif std_match(input, "10") then next_state <= st1; output <= "-";
        elsif std_match(input, "01") then next_state <= st2; output <= "-";
        end if;
      when st1 =>
        if std_match(input, "10") then next_state <= st1; output <= "1";
        elsif std_match(input, "00") then next_state <= st3; output <= "1";
        elsif std_match(input, "11") then next_state <= st5; output <= "1";
        end if;
      when st2 =>
        if std_match(input, "01") then next_state <= st2; output <= "1";
        elsif std_match(input, "00") then next_state <= st7; output <= "1";
        elsif std_match(input, "11") then next_state <= st9; output <= "1";
        end if;
      when st3 =>
        if std_match(input, "00") then next_state <= st3; output <= "1";
        elsif std_match(input, "01") then next_state <= st4; output <= "1";
        end if;
      when st4 =>
        if std_match(input, "01") then next_state <= st4; output <= "1";
        elsif std_match(input, "00") then next_state <= st0; output <= "-";
        end if;
      when st5 =>
        if std_match(input, "11") then next_state <= st5; output <= "1";
        elsif std_match(input, "01") then next_state <= st6; output <= "1";
        end if;
      when st6 =>
        if std_match(input, "01") then next_state <= st6; output <= "1";
        elsif std_match(input, "00") then next_state <= st0; output <= "-";
        end if;
      when st7 =>
        if std_match(input, "00") then next_state <= st7; output <= "1";
        elsif std_match(input, "10") then next_state <= st8; output <= "1";
        end if;
      when st8 =>
        if std_match(input, "10") then next_state <= st8; output <= "1";
        elsif std_match(input, "00") then next_state <= st0; output <= "-";
        end if;
      when st9 =>
        if std_match(input, "11") then next_state <= st9; output <= "1";
        elsif std_match(input, "10") then next_state <= st10; output <= "1";
        end if;
      when st10 =>
        if std_match(input, "10") then next_state <= st10; output <= "1";
        elsif std_match(input, "00") then next_state <= st0; output <= "-";
        end if;
      when others => next_state <= "----"; output <= "-";
    end case;
  end process;
end behaviour;
