library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity donfile_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(1 downto 0);
    output: out std_logic_vector(0 downto 0)
  );
end donfile_rnd;
architecture behaviour of donfile_rnd is
  constant st0: std_logic_vector(4 downto 0) := "11101";
  constant st6: std_logic_vector(4 downto 0) := "00010";
  constant st12: std_logic_vector(4 downto 0) := "11011";
  constant st18: std_logic_vector(4 downto 0) := "11110";
  constant st1: std_logic_vector(4 downto 0) := "11111";
  constant st7: std_logic_vector(4 downto 0) := "10001";
  constant st2: std_logic_vector(4 downto 0) := "10110";
  constant st19: std_logic_vector(4 downto 0) := "01011";
  constant st3: std_logic_vector(4 downto 0) := "01111";
  constant st13: std_logic_vector(4 downto 0) := "00001";
  constant st4: std_logic_vector(4 downto 0) := "10000";
  constant st5: std_logic_vector(4 downto 0) := "11010";
  constant st14: std_logic_vector(4 downto 0) := "11000";
  constant st20: std_logic_vector(4 downto 0) := "01000";
  constant st8: std_logic_vector(4 downto 0) := "00100";
  constant st21: std_logic_vector(4 downto 0) := "01001";
  constant st9: std_logic_vector(4 downto 0) := "00110";
  constant st15: std_logic_vector(4 downto 0) := "11100";
  constant st10: std_logic_vector(4 downto 0) := "00011";
  constant st11: std_logic_vector(4 downto 0) := "10111";
  constant st22: std_logic_vector(4 downto 0) := "10011";
  constant st23: std_logic_vector(4 downto 0) := "10010";
  constant st16: std_logic_vector(4 downto 0) := "00111";
  constant st17: std_logic_vector(4 downto 0) := "01100";
  signal current_state, next_state: std_logic_vector(4 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-----"; output <= "-";
    case current_state is
      when st0 =>
        if std_match(input, "00") then next_state <= st0; output <= "1";
        elsif std_match(input, "01") then next_state <= st6; output <= "1";
        elsif std_match(input, "10") then next_state <= st12; output <= "1";
        elsif std_match(input, "11") then next_state <= st18; output <= "1";
        end if;
      when st1 =>
        if std_match(input, "00") then next_state <= st1; output <= "1";
        elsif std_match(input, "01") then next_state <= st7; output <= "1";
        elsif std_match(input, "10") then next_state <= st12; output <= "1";
        elsif std_match(input, "11") then next_state <= st18; output <= "1";
        end if;
      when st2 =>
        if std_match(input, "00") then next_state <= st2; output <= "1";
        elsif std_match(input, "01") then next_state <= st6; output <= "1";
        elsif std_match(input, "10") then next_state <= st12; output <= "1";
        elsif std_match(input, "11") then next_state <= st19; output <= "1";
        end if;
      when st3 =>
        if std_match(input, "00") then next_state <= st3; output <= "1";
        elsif std_match(input, "01") then next_state <= st6; output <= "1";
        elsif std_match(input, "10") then next_state <= st13; output <= "1";
        elsif std_match(input, "11") then next_state <= st19; output <= "1";
        end if;
      when st4 =>
        if std_match(input, "00") then next_state <= st4; output <= "1";
        elsif std_match(input, "01") then next_state <= st7; output <= "1";
        elsif std_match(input, "10") then next_state <= st13; output <= "1";
        elsif std_match(input, "11") then next_state <= st18; output <= "1";
        end if;
      when st5 =>
        if std_match(input, "00") then next_state <= st5; output <= "1";
        elsif std_match(input, "01") then next_state <= st7; output <= "1";
        elsif std_match(input, "10") then next_state <= st13; output <= "1";
        elsif std_match(input, "11") then next_state <= st19; output <= "1";
        end if;
      when st6 =>
        if std_match(input, "00") then next_state <= st0; output <= "1";
        elsif std_match(input, "01") then next_state <= st6; output <= "1";
        elsif std_match(input, "10") then next_state <= st14; output <= "1";
        elsif std_match(input, "11") then next_state <= st20; output <= "1";
        end if;
      when st7 =>
        if std_match(input, "00") then next_state <= st1; output <= "1";
        elsif std_match(input, "01") then next_state <= st7; output <= "1";
        elsif std_match(input, "10") then next_state <= st14; output <= "1";
        elsif std_match(input, "11") then next_state <= st20; output <= "1";
        end if;
      when st8 =>
        if std_match(input, "00") then next_state <= st0; output <= "1";
        elsif std_match(input, "01") then next_state <= st8; output <= "1";
        elsif std_match(input, "10") then next_state <= st14; output <= "1";
        elsif std_match(input, "11") then next_state <= st21; output <= "1";
        end if;
      when st9 =>
        if std_match(input, "00") then next_state <= st0; output <= "1";
        elsif std_match(input, "01") then next_state <= st9; output <= "1";
        elsif std_match(input, "10") then next_state <= st15; output <= "1";
        elsif std_match(input, "11") then next_state <= st21; output <= "1";
        end if;
      when st10 =>
        if std_match(input, "00") then next_state <= st1; output <= "1";
        elsif std_match(input, "01") then next_state <= st10; output <= "1";
        elsif std_match(input, "10") then next_state <= st15; output <= "1";
        elsif std_match(input, "11") then next_state <= st20; output <= "1";
        end if;
      when st11 =>
        if std_match(input, "00") then next_state <= st1; output <= "1";
        elsif std_match(input, "01") then next_state <= st11; output <= "1";
        elsif std_match(input, "10") then next_state <= st15; output <= "1";
        elsif std_match(input, "11") then next_state <= st21; output <= "1";
        end if;
      when st12 =>
        if std_match(input, "00") then next_state <= st2; output <= "1";
        elsif std_match(input, "01") then next_state <= st8; output <= "1";
        elsif std_match(input, "10") then next_state <= st12; output <= "1";
        elsif std_match(input, "11") then next_state <= st22; output <= "1";
        end if;
      when st13 =>
        if std_match(input, "00") then next_state <= st3; output <= "1";
        elsif std_match(input, "01") then next_state <= st8; output <= "1";
        elsif std_match(input, "10") then next_state <= st13; output <= "1";
        elsif std_match(input, "11") then next_state <= st22; output <= "1";
        end if;
      when st14 =>
        if std_match(input, "00") then next_state <= st2; output <= "1";
        elsif std_match(input, "01") then next_state <= st8; output <= "1";
        elsif std_match(input, "10") then next_state <= st14; output <= "1";
        elsif std_match(input, "11") then next_state <= st23; output <= "1";
        end if;
      when st15 =>
        if std_match(input, "00") then next_state <= st2; output <= "1";
        elsif std_match(input, "01") then next_state <= st9; output <= "1";
        elsif std_match(input, "10") then next_state <= st15; output <= "1";
        elsif std_match(input, "11") then next_state <= st23; output <= "1";
        end if;
      when st16 =>
        if std_match(input, "00") then next_state <= st3; output <= "1";
        elsif std_match(input, "01") then next_state <= st9; output <= "1";
        elsif std_match(input, "10") then next_state <= st16; output <= "1";
        elsif std_match(input, "11") then next_state <= st22; output <= "1";
        end if;
      when st17 =>
        if std_match(input, "00") then next_state <= st3; output <= "1";
        elsif std_match(input, "01") then next_state <= st9; output <= "1";
        elsif std_match(input, "10") then next_state <= st17; output <= "1";
        elsif std_match(input, "11") then next_state <= st23; output <= "1";
        end if;
      when st18 =>
        if std_match(input, "00") then next_state <= st4; output <= "1";
        elsif std_match(input, "01") then next_state <= st10; output <= "1";
        elsif std_match(input, "10") then next_state <= st16; output <= "1";
        elsif std_match(input, "11") then next_state <= st18; output <= "1";
        end if;
      when st19 =>
        if std_match(input, "00") then next_state <= st5; output <= "1";
        elsif std_match(input, "01") then next_state <= st10; output <= "1";
        elsif std_match(input, "10") then next_state <= st16; output <= "1";
        elsif std_match(input, "11") then next_state <= st19; output <= "1";
        end if;
      when st20 =>
        if std_match(input, "00") then next_state <= st4; output <= "1";
        elsif std_match(input, "01") then next_state <= st10; output <= "1";
        elsif std_match(input, "10") then next_state <= st17; output <= "1";
        elsif std_match(input, "11") then next_state <= st20; output <= "1";
        end if;
      when st21 =>
        if std_match(input, "00") then next_state <= st4; output <= "1";
        elsif std_match(input, "01") then next_state <= st11; output <= "1";
        elsif std_match(input, "10") then next_state <= st17; output <= "1";
        elsif std_match(input, "11") then next_state <= st21; output <= "1";
        end if;
      when st22 =>
        if std_match(input, "00") then next_state <= st5; output <= "1";
        elsif std_match(input, "01") then next_state <= st11; output <= "1";
        elsif std_match(input, "10") then next_state <= st16; output <= "1";
        elsif std_match(input, "11") then next_state <= st22; output <= "1";
        end if;
      when st23 =>
        if std_match(input, "00") then next_state <= st5; output <= "1";
        elsif std_match(input, "01") then next_state <= st11; output <= "1";
        elsif std_match(input, "10") then next_state <= st17; output <= "1";
        elsif std_match(input, "11") then next_state <= st23; output <= "1";
        end if;
      when others => next_state <= "-----"; output <= "-";
    end case;
  end process;
end behaviour;
