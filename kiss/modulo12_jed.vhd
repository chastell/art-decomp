library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity modulo12_jed is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(0 downto 0);
    output: out std_logic_vector(0 downto 0)
  );
end modulo12_jed;
architecture behaviour of modulo12_jed is
  constant st0: std_logic_vector(3 downto 0) := "1001";
  constant st1: std_logic_vector(3 downto 0) := "1101";
  constant st2: std_logic_vector(3 downto 0) := "1111";
  constant st3: std_logic_vector(3 downto 0) := "1011";
  constant st4: std_logic_vector(3 downto 0) := "1010";
  constant st5: std_logic_vector(3 downto 0) := "1110";
  constant st6: std_logic_vector(3 downto 0) := "0010";
  constant st7: std_logic_vector(3 downto 0) := "0001";
  constant st8: std_logic_vector(3 downto 0) := "0000";
  constant st9: std_logic_vector(3 downto 0) := "0100";
  constant st10: std_logic_vector(3 downto 0) := "1100";
  constant st11: std_logic_vector(3 downto 0) := "1000";
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
        if std_match(input, "0") then next_state <= st0; output <= "0";
        elsif std_match(input, "1") then next_state <= st1; output <= "0";
        end if;
      when st1 =>
        if std_match(input, "0") then next_state <= st1; output <= "0";
        elsif std_match(input, "1") then next_state <= st2; output <= "0";
        end if;
      when st2 =>
        if std_match(input, "0") then next_state <= st2; output <= "0";
        elsif std_match(input, "1") then next_state <= st3; output <= "0";
        end if;
      when st3 =>
        if std_match(input, "0") then next_state <= st3; output <= "0";
        elsif std_match(input, "1") then next_state <= st4; output <= "0";
        end if;
      when st4 =>
        if std_match(input, "0") then next_state <= st4; output <= "0";
        elsif std_match(input, "1") then next_state <= st5; output <= "0";
        end if;
      when st5 =>
        if std_match(input, "0") then next_state <= st5; output <= "0";
        elsif std_match(input, "1") then next_state <= st6; output <= "0";
        end if;
      when st6 =>
        if std_match(input, "0") then next_state <= st6; output <= "0";
        elsif std_match(input, "1") then next_state <= st7; output <= "0";
        end if;
      when st7 =>
        if std_match(input, "0") then next_state <= st7; output <= "0";
        elsif std_match(input, "1") then next_state <= st8; output <= "0";
        end if;
      when st8 =>
        if std_match(input, "0") then next_state <= st8; output <= "0";
        elsif std_match(input, "1") then next_state <= st9; output <= "0";
        end if;
      when st9 =>
        if std_match(input, "0") then next_state <= st9; output <= "0";
        elsif std_match(input, "1") then next_state <= st10; output <= "0";
        end if;
      when st10 =>
        if std_match(input, "0") then next_state <= st10; output <= "0";
        elsif std_match(input, "1") then next_state <= st11; output <= "0";
        end if;
      when st11 =>
        if std_match(input, "0") then next_state <= st11; output <= "0";
        elsif std_match(input, "1") then next_state <= st0; output <= "0";
        end if;
      when others => next_state <= "----"; output <= "-";
    end case;
  end process;
end behaviour;
