library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity opus_nov is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(4 downto 0);
    output: out std_logic_vector(5 downto 0)
  );
end opus_nov;
architecture behaviour of opus_nov is
  constant init0: std_logic_vector(3 downto 0) := "0001";
  constant init1: std_logic_vector(3 downto 0) := "1000";
  constant init2: std_logic_vector(3 downto 0) := "1100";
  constant init4: std_logic_vector(3 downto 0) := "0011";
  constant IOwait: std_logic_vector(3 downto 0) := "0000";
  constant RMACK: std_logic_vector(3 downto 0) := "1101";
  constant WMACK: std_logic_vector(3 downto 0) := "0010";
  constant read0: std_logic_vector(3 downto 0) := "1010";
  constant read1: std_logic_vector(3 downto 0) := "1111";
  constant write0: std_logic_vector(3 downto 0) := "1110";
  signal current_state, next_state: std_logic_vector(3 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "----"; output <= "------";
    if std_match(input, "--1--") then next_state <= init0; output <= "110000";
    else
    case current_state is
      when init0 =>
        if std_match(input, "--1--") then next_state <= init0; output <= "110000";
        elsif std_match(input, "--0--") then next_state <= init1; output <= "110000";
        end if;
      when init1 =>
        if std_match(input, "--00-") then next_state <= init1; output <= "110000";
        elsif std_match(input, "--01-") then next_state <= init2; output <= "110001";
        end if;
      when init2 =>
        if std_match(input, "--0--") then next_state <= init4; output <= "110100";
        end if;
      when init4 =>
        if std_match(input, "--01-") then next_state <= init4; output <= "110100";
        elsif std_match(input, "--00-") then next_state <= IOwait; output <= "000000";
        end if;
      when IOwait =>
        if std_match(input, "0000-") then next_state <= IOwait; output <= "000000";
        elsif std_match(input, "1000-") then next_state <= init1; output <= "110000";
        elsif std_match(input, "01000") then next_state <= read0; output <= "101000";
        elsif std_match(input, "11000") then next_state <= write0; output <= "100010";
        elsif std_match(input, "01001") then next_state <= RMACK; output <= "100000";
        elsif std_match(input, "11001") then next_state <= WMACK; output <= "100000";
        elsif std_match(input, "--01-") then next_state <= init2; output <= "110001";
        end if;
      when RMACK =>
        if std_match(input, "--0-0") then next_state <= RMACK; output <= "100000";
        elsif std_match(input, "--0-1") then next_state <= read0; output <= "101000";
        end if;
      when WMACK =>
        if std_match(input, "--0-0") then next_state <= WMACK; output <= "100000";
        elsif std_match(input, "--0-1") then next_state <= write0; output <= "100010";
        end if;
      when read0 =>
        if std_match(input, "--0--") then next_state <= read1; output <= "101001";
        end if;
      when read1 =>
        if std_match(input, "--0--") then next_state <= IOwait; output <= "000000";
        end if;
      when write0 =>
        if std_match(input, "--0--") then next_state <= IOwait; output <= "000000";
        end if;
      when others => next_state <= "----"; output <= "------";
    end case;
    end if;
  end process;
end behaviour;
