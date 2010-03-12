library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity beecount_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(2 downto 0);
    output: out std_logic_vector(3 downto 0)
  );
end beecount_hot;
architecture behaviour of beecount_hot is
  constant st0: std_logic_vector(6 downto 0) := "1000000";
  constant st1: std_logic_vector(6 downto 0) := "0100000";
  constant st4: std_logic_vector(6 downto 0) := "0010000";
  constant st2: std_logic_vector(6 downto 0) := "0001000";
  constant st3: std_logic_vector(6 downto 0) := "0000100";
  constant st5: std_logic_vector(6 downto 0) := "0000010";
  constant st6: std_logic_vector(6 downto 0) := "0000001";
  signal current_state, next_state: std_logic_vector(6 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-------"; output <= "----";
    case current_state is
      when st0 =>
        if std_match(input, "000") then next_state <= st0; output <= "0101";
        elsif std_match(input, "100") then next_state <= st1; output <= "0101";
        elsif std_match(input, "010") then next_state <= st4; output <= "0101";
        elsif std_match(input, "--1") then next_state <= st0; output <= "1010";
        end if;
      when st1 =>
        if std_match(input, "100") then next_state <= st1; output <= "0101";
        elsif std_match(input, "0-0") then next_state <= st0; output <= "0101";
        elsif std_match(input, "110") then next_state <= st2; output <= "0101";
        elsif std_match(input, "--1") then next_state <= st0; output <= "1010";
        end if;
      when st2 =>
        if std_match(input, "110") then next_state <= st2; output <= "0101";
        elsif std_match(input, "100") then next_state <= st1; output <= "0101";
        elsif std_match(input, "010") then next_state <= st3; output <= "0101";
        elsif std_match(input, "--1") then next_state <= st0; output <= "1010";
        end if;
      when st3 =>
        if std_match(input, "010") then next_state <= st3; output <= "0101";
        elsif std_match(input, "110") then next_state <= st2; output <= "0101";
        elsif std_match(input, "000") then next_state <= st0; output <= "0110";
        elsif std_match(input, "--1") then next_state <= st0; output <= "1010";
        end if;
      when st4 =>
        if std_match(input, "010") then next_state <= st4; output <= "0101";
        elsif std_match(input, "-00") then next_state <= st0; output <= "0101";
        elsif std_match(input, "110") then next_state <= st5; output <= "0101";
        elsif std_match(input, "--1") then next_state <= st0; output <= "1010";
        end if;
      when st5 =>
        if std_match(input, "110") then next_state <= st5; output <= "0101";
        elsif std_match(input, "010") then next_state <= st4; output <= "0101";
        elsif std_match(input, "100") then next_state <= st6; output <= "0101";
        elsif std_match(input, "--1") then next_state <= st0; output <= "1010";
        end if;
      when st6 =>
        if std_match(input, "100") then next_state <= st6; output <= "0101";
        elsif std_match(input, "110") then next_state <= st5; output <= "0101";
        elsif std_match(input, "000") then next_state <= st0; output <= "1001";
        elsif std_match(input, "--1") then next_state <= st0; output <= "1010";
        end if;
      when others => next_state <= "-------"; output <= "----";
    end case;
  end process;
end behaviour;
