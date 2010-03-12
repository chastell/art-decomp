library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity dk27_rnd is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(0 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end dk27_rnd;
architecture behaviour of dk27_rnd is
  constant START: std_logic_vector(2 downto 0) := "101";
  constant state6: std_logic_vector(2 downto 0) := "010";
  constant state2: std_logic_vector(2 downto 0) := "011";
  constant state5: std_logic_vector(2 downto 0) := "110";
  constant state3: std_logic_vector(2 downto 0) := "111";
  constant state4: std_logic_vector(2 downto 0) := "001";
  constant state7: std_logic_vector(2 downto 0) := "000";
  signal current_state, next_state: std_logic_vector(2 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---"; output <= "--";
    case current_state is
      when START =>
        if std_match(input, "0") then next_state <= state6; output <= "00";
        elsif std_match(input, "1") then next_state <= state4; output <= "00";
        end if;
      when state2 =>
        if std_match(input, "0") then next_state <= state5; output <= "00";
        elsif std_match(input, "1") then next_state <= state3; output <= "00";
        end if;
      when state3 =>
        if std_match(input, "0") then next_state <= state5; output <= "00";
        elsif std_match(input, "1") then next_state <= state7; output <= "00";
        end if;
      when state4 =>
        if std_match(input, "0") then next_state <= state6; output <= "00";
        elsif std_match(input, "1") then next_state <= state6; output <= "10";
        end if;
      when state5 =>
        if std_match(input, "0") then next_state <= START; output <= "10";
        elsif std_match(input, "1") then next_state <= state2; output <= "10";
        end if;
      when state6 =>
        if std_match(input, "0") then next_state <= START; output <= "01";
        elsif std_match(input, "1") then next_state <= state2; output <= "01";
        end if;
      when state7 =>
        if std_match(input, "0") then next_state <= state5; output <= "00";
        elsif std_match(input, "1") then next_state <= state6; output <= "10";
        end if;
      when others => next_state <= "---"; output <= "--";
    end case;
  end process;
end behaviour;
