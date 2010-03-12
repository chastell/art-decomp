library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity tma_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(6 downto 0);
    output: out std_logic_vector(5 downto 0)
  );
end tma_hot;
architecture behaviour of tma_hot is
  constant I0: std_logic_vector(19 downto 0) := "10000000000000000000";
  constant T1: std_logic_vector(19 downto 0) := "01000000000000000000";
  constant R1: std_logic_vector(19 downto 0) := "00100000000000000000";
  constant T3: std_logic_vector(19 downto 0) := "00010000000000000000";
  constant T9: std_logic_vector(19 downto 0) := "00001000000000000000";
  constant T4: std_logic_vector(19 downto 0) := "00000100000000000000";
  constant T5: std_logic_vector(19 downto 0) := "00000010000000000000";
  constant T6: std_logic_vector(19 downto 0) := "00000001000000000000";
  constant T7: std_logic_vector(19 downto 0) := "00000000100000000000";
  constant T8: std_logic_vector(19 downto 0) := "00000000010000000000";
  constant I2: std_logic_vector(19 downto 0) := "00000000001000000000";
  constant T2: std_logic_vector(19 downto 0) := "00000000000100000000";
  constant R2: std_logic_vector(19 downto 0) := "00000000000010000000";
  constant I1: std_logic_vector(19 downto 0) := "00000000000001000000";
  constant R3: std_logic_vector(19 downto 0) := "00000000000000100000";
  constant R4: std_logic_vector(19 downto 0) := "00000000000000010000";
  constant R6: std_logic_vector(19 downto 0) := "00000000000000001000";
  constant R8: std_logic_vector(19 downto 0) := "00000000000000000100";
  constant R5: std_logic_vector(19 downto 0) := "00000000000000000010";
  constant R7: std_logic_vector(19 downto 0) := "00000000000000000001";
  signal current_state, next_state: std_logic_vector(19 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "--------------------"; output <= "------";
    case current_state is
      when I0 =>
        if std_match(input, "11110--") then next_state <= T1; output <= "000000";
        elsif std_match(input, "101-1--") then next_state <= R1; output <= "000000";
        end if;
      when T1 =>
        if std_match(input, "1110---") then next_state <= T3; output <= "100000";
        elsif std_match(input, "100----") then next_state <= T9; output <= "100000";
        elsif std_match(input, "101--1-") then next_state <= T9; output <= "100000";
        end if;
      when T3 =>
        if std_match(input, "111----") then next_state <= T4; output <= "110000";
        elsif std_match(input, "100----") then next_state <= T9; output <= "110000";
        elsif std_match(input, "101--1-") then next_state <= T9; output <= "110000";
        end if;
      when T4 =>
        if std_match(input, "111----") then next_state <= T5; output <= "001000";
        elsif std_match(input, "100----") then next_state <= T9; output <= "001000";
        elsif std_match(input, "101--1-") then next_state <= T9; output <= "001000";
        end if;
      when T5 =>
        if std_match(input, "111-0--") then next_state <= T6; output <= "101000";
        elsif std_match(input, "100----") then next_state <= T9; output <= "101000";
        elsif std_match(input, "101-1--") then next_state <= T9; output <= "101000";
        end if;
      when T6 =>
        if std_match(input, "101-0--") then next_state <= T7; output <= "011000";
        elsif std_match(input, "101-1--") then next_state <= T8; output <= "011000";
        elsif std_match(input, "100----") then next_state <= T9; output <= "011000";
        end if;
      when T7 =>
        if std_match(input, "10-----") then next_state <= I2; output <= "111000";
        end if;
      when T8 =>
        if std_match(input, "10-----") then next_state <= I2; output <= "000100";
        end if;
      when T9 =>
        if std_match(input, "101-0--") then next_state <= T2; output <= "100100";
        elsif std_match(input, "100----") then next_state <= T2; output <= "100100";
        end if;
      when T2 =>
        if std_match(input, "10-----") then next_state <= T8; output <= "010100";
        end if;
      when R1 =>
        if std_match(input, "101-1--") then next_state <= R2; output <= "100010";
        elsif std_match(input, "100----") then next_state <= I1; output <= "100010";
        elsif std_match(input, "101-0--") then next_state <= I2; output <= "100010";
        end if;
      when R2 =>
        if std_match(input, "101-1--") then next_state <= R3; output <= "010010";
        elsif std_match(input, "100----") then next_state <= I1; output <= "010010";
        elsif std_match(input, "101-0--") then next_state <= I2; output <= "010010";
        end if;
      when R3 =>
        if std_match(input, "101-1--") then next_state <= R4; output <= "110010";
        elsif std_match(input, "101-0-0") then next_state <= R6; output <= "110010";
        elsif std_match(input, "101-0-1") then next_state <= R8; output <= "110010";
        elsif std_match(input, "100----") then next_state <= R5; output <= "110010";
        end if;
      when R4 =>
        if std_match(input, "101-0-0") then next_state <= R6; output <= "001010";
        elsif std_match(input, "101-0-1") then next_state <= R8; output <= "001010";
        elsif std_match(input, "100----") then next_state <= R5; output <= "001010";
        end if;
      when R6 =>
        if std_match(input, "101-0--") then next_state <= R7; output <= "011010";
        elsif std_match(input, "101-1--") then next_state <= R5; output <= "011010";
        elsif std_match(input, "100----") then next_state <= R5; output <= "011010";
        end if;
      when R7 =>
        if std_match(input, "10-----") then next_state <= I2; output <= "111010";
        end if;
      when R8 =>
        if std_match(input, "10-----") then next_state <= R5; output <= "000110";
        end if;
      when R5 =>
        if std_match(input, "101----") then next_state <= I2; output <= "100110";
        elsif std_match(input, "100----") then next_state <= I1; output <= "100110";
        end if;
      when I2 =>
        if std_match(input, "-------") then next_state <= I0; output <= "000001";
        end if;
      when I1 =>
        if std_match(input, "111-0--") then next_state <= I0; output <= "010111";
        end if;
      when others => next_state <= "--------------------"; output <= "------";
    end case;
  end process;
end behaviour;
