library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity mark1_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(4 downto 0);
    output: out std_logic_vector(15 downto 0)
  );
end mark1_hot;
architecture behaviour of mark1_hot is
  constant state1: std_logic_vector(14 downto 0) := "100000000000000";
  constant state3: std_logic_vector(14 downto 0) := "010000000000000";
  constant state2: std_logic_vector(14 downto 0) := "001000000000000";
  constant state0: std_logic_vector(14 downto 0) := "000100000000000";
  constant state4: std_logic_vector(14 downto 0) := "000010000000000";
  constant state13: std_logic_vector(14 downto 0) := "000001000000000";
  constant state10: std_logic_vector(14 downto 0) := "000000100000000";
  constant state9: std_logic_vector(14 downto 0) := "000000010000000";
  constant state8: std_logic_vector(14 downto 0) := "000000001000000";
  constant state7: std_logic_vector(14 downto 0) := "000000000100000";
  constant state6: std_logic_vector(14 downto 0) := "000000000010000";
  constant state5: std_logic_vector(14 downto 0) := "000000000001000";
  constant state14: std_logic_vector(14 downto 0) := "000000000000100";
  constant state11: std_logic_vector(14 downto 0) := "000000000000010";
  constant state12: std_logic_vector(14 downto 0) := "000000000000001";
  signal current_state, next_state: std_logic_vector(14 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "---------------"; output <= "----------------";
    if std_match(input, "0----") then next_state <= state1; output <= "-11---1-00------";
    else
    case current_state is
      when state1 =>
        if std_match(input, "1----") then next_state <= state3; output <= "-11---1-00------";
        end if;
      when state2 =>
        if std_match(input, "1----") then next_state <= state0; output <= "-11---1-00------";
        end if;
      when state3 =>
        if std_match(input, "1----") then next_state <= state4; output <= "101---1-01------";
        end if;
      when state4 =>
        if std_match(input, "1-111") then next_state <= state13; output <= "-11---1-00------";
        elsif std_match(input, "1-110") then next_state <= state10; output <= "-11---1-00------";
        elsif std_match(input, "1-10-") then next_state <= state9; output <= "-11---1-00------";
        elsif std_match(input, "1-011") then next_state <= state8; output <= "-11---1-00------";
        elsif std_match(input, "1-010") then next_state <= state7; output <= "-11---1-00------";
        elsif std_match(input, "1-001") then next_state <= state6; output <= "-11---1-00------";
        elsif std_match(input, "1-000") then next_state <= state5; output <= "-11---1-00------";
        end if;
      when state5 =>
        if std_match(input, "1----") then next_state <= state14; output <= "0011--1-00------";
        end if;
      when state6 =>
        if std_match(input, "1----") then next_state <= state14; output <= "00100-0-00000011";
        end if;
      when state7 =>
        if std_match(input, "1----") then next_state <= state14; output <= "001---1100------";
        end if;
      when state8 =>
        if std_match(input, "1----") then next_state <= state14; output <= "010---1-00------";
        end if;
      when state9 =>
        if std_match(input, "1----") then next_state <= state14; output <= "001---1010000101";
        end if;
      when state10 =>
        if std_match(input, "1----") then next_state <= state11; output <= "-11---1-00100000";
        end if;
      when state11 =>
        if std_match(input, "10---") then next_state <= state13; output <= "-11---1-00------";
        elsif std_match(input, "11---") then next_state <= state12; output <= "-11---1-00------";
        end if;
      when state12 =>
        if std_match(input, "1----") then next_state <= state13; output <= "-110110-00------";
        end if;
      when state13 =>
        if std_match(input, "1----") then next_state <= state14; output <= "-11---1-00------";
        end if;
      when state14 =>
        if std_match(input, "1----") then next_state <= state3; output <= "-110110-00------";
        end if;
      when state0 =>
        if std_match(input, "0----") then next_state <= state1; output <= "-11---1-00------";
        end if;
      when others => next_state <= "---------------"; output <= "----------------";
    end case;
    end if;
  end process;
end behaviour;
