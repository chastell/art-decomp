library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity mc_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(2 downto 0);
    output: out std_logic_vector(4 downto 0)
  );
end mc_hot;
architecture behaviour of mc_hot is
  constant HG: std_logic_vector(3 downto 0) := "1000";
  constant HY: std_logic_vector(3 downto 0) := "0100";
  constant FG: std_logic_vector(3 downto 0) := "0010";
  constant FY: std_logic_vector(3 downto 0) := "0001";
  signal current_state, next_state: std_logic_vector(3 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "----"; output <= "-----";
    case current_state is
      when HG =>
        if std_match(input, "0--") then next_state <= HG; output <= "00010";
        elsif std_match(input, "-0-") then next_state <= HG; output <= "00010";
        elsif std_match(input, "11-") then next_state <= HY; output <= "10010";
        end if;
      when HY =>
        if std_match(input, "--0") then next_state <= HY; output <= "00110";
        elsif std_match(input, "--1") then next_state <= FG; output <= "10110";
        end if;
      when FG =>
        if std_match(input, "10-") then next_state <= FG; output <= "01000";
        elsif std_match(input, "0--") then next_state <= FY; output <= "11000";
        elsif std_match(input, "-1-") then next_state <= FY; output <= "11000";
        end if;
      when FY =>
        if std_match(input, "--0") then next_state <= FY; output <= "01001";
        elsif std_match(input, "--1") then next_state <= HG; output <= "11001";
        end if;
      when others => next_state <= "----"; output <= "-----";
    end case;
  end process;
end behaviour;
