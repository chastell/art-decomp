library ieee;
use ieee.std_logic_1164.all;
entity fsm is
  port(
    clock:  in  std_logic;
    reset:  in  std_logic;
    input:  in  std_logic_vector(3 downto 0);
    output: out std_logic_vector(1 downto 0)
  );
end fsm;
architecture behaviour of fsm is
  type state is (init0, init1, init2, init4, IOwait, RMACK, WMACK, read0, read1, write0);
  signal current_state, next_state: state;
begin
  process(clock, reset) begin
    if clock'event and clock = '1' then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    case current_state is
      when init0 =>
        if input = "--00" then next_state <= init1; output <= "00";
        end if;
      when init1 =>
        if input = "0100" then next_state <= init1; output <= "00";
        elsif input = "--1-" then next_state <= init2; output <= "10";
        end if;
      when init2 =>
        if input = "1-10" then next_state <= init4; output <= "10";
        end if;
      when init4 =>
        if input = "-111" then next_state <= init4; output <= "10";
        elsif input = "--01" then next_state <= IOwait; output <= "01";
        end if;
      when IOwait =>
        if input = "000-" then next_state <= IOwait; output <= "01";
        elsif input = "100-" then next_state <= init1; output <= "01";
        elsif input = "0110" then next_state <= read0; output <= "00";
        elsif input = "1100" then next_state <= write0; output <= "11";
        elsif input = "0111" then next_state <= RMACK; output <= "11";
        elsif input = "1101" then next_state <= WMACK; output <= "00";
        elsif input = "-01-" then next_state <= init2; output <= "01";
        end if;
      when RMACK =>
        if input = "0010" then next_state <= RMACK; output <= "11";
        elsif input = "0111" then next_state <= read0; output <= "00";
        end if;
      when WMACK =>
        if input = "1100" then next_state <= WMACK; output <= "00";
        elsif input = "1001" then next_state <= write0; output <= "01";
        end if;
      when read0 =>
        if input = "0001" then next_state <= read1; output <= "11";
        end if;
      when read1 =>
        if input = "0010" then next_state <= IOwait; output <= "01";
        end if;
      when write0 =>
        if input = "0100" then next_state <= IOwait; output <= "01";
        end if;
    end case;
  end process;
end behaviour;
