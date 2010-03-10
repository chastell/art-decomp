library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity mark1 is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(4 downto 0);
    output: out std_logic_vector(15 downto 0)
  );
end mark1;
architecture behaviour of mark1 is
  type state is (state1, state2, state3, state4, state5, state6, state7, state8, state9, state10, state11, state12, state13, state14, state0);
  signal current_state, next_state: state;
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= state1; output <= "----------------";
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
    end case;
    end if;
  end process;
end behaviour;
