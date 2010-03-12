library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity s386_hot is
  port(
    clock:  in  std_logic;
    input:  in  std_logic_vector(6 downto 0);
    output: out std_logic_vector(6 downto 0)
  );
end s386_hot;
architecture behaviour of s386_hot is
  constant s000000: std_logic_vector(12 downto 0) := "1000000000000";
  constant s001100: std_logic_vector(12 downto 0) := "0100000000000";
  constant s010010: std_logic_vector(12 downto 0) := "0010000000000";
  constant s010000: std_logic_vector(12 downto 0) := "0001000000000";
  constant s001000: std_logic_vector(12 downto 0) := "0000100000000";
  constant s000100: std_logic_vector(12 downto 0) := "0000010000000";
  constant s000011: std_logic_vector(12 downto 0) := "0000001000000";
  constant s010001: std_logic_vector(12 downto 0) := "0000000100000";
  constant s010011: std_logic_vector(12 downto 0) := "0000000010000";
  constant s110000: std_logic_vector(12 downto 0) := "0000000001000";
  constant s100000: std_logic_vector(12 downto 0) := "0000000000100";
  constant s000010: std_logic_vector(12 downto 0) := "0000000000010";
  constant s000001: std_logic_vector(12 downto 0) := "0000000000001";
  signal current_state, next_state: std_logic_vector(12 downto 0);
begin
  process(clock) begin
    if rising_edge(clock) then current_state <= next_state;
    end if;
  end process;
  process(input, current_state) begin
    next_state <= "-------------"; output <= "-------";
    case current_state is
      when s000000 =>
        if std_match(input, "----11-") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "----100") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "--1-101") then next_state <= s010010; output <= "0000001";
        elsif std_match(input, "--0-101") then next_state <= s010000; output <= "0000001";
        elsif std_match(input, "----0-0") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "----011") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "----001") then next_state <= s000000; output <= "0000000";
        end if;
      when s001100 =>
        if std_match(input, "-1---00") then next_state <= s001000; output <= "1000000";
        elsif std_match(input, "-0---00") then next_state <= s001100; output <= "0000000";
        elsif std_match(input, "-----01") then next_state <= s000000; output <= "0000000";
        elsif std_match(input, "-0---10") then next_state <= s001100; output <= "0000000";
        elsif std_match(input, "-1---10") then next_state <= s001000; output <= "1000000";
        elsif std_match(input, "-0---11") then next_state <= s001100; output <= "0000000";
        elsif std_match(input, "-1---11") then next_state <= s000100; output <= "0010000";
        end if;
      when s001000 =>
        if std_match(input, "-----00") then next_state <= s001000; output <= "0000000";
        elsif std_match(input, "0----01") then next_state <= s000000; output <= "0101100";
        elsif std_match(input, "1----01") then next_state <= s000000; output <= "0101000";
        elsif std_match(input, "0----11") then next_state <= s001100; output <= "0101100";
        elsif std_match(input, "1----11") then next_state <= s001100; output <= "0101000";
        elsif std_match(input, "-----10") then next_state <= s001000; output <= "0000000";
        end if;
      when s000100 =>
        if std_match(input, "-----00") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----10") then next_state <= s001100; output <= "0110000";
        elsif std_match(input, "-----11") then next_state <= s000100; output <= "0010000";
        elsif std_match(input, "-----01") then next_state <= s000000; output <= "0000000";
        end if;
      when s010010 =>
        if std_match(input, "------0") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----11") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----01") then next_state <= s000011; output <= "0000000";
        end if;
      when s000011 =>
        if std_match(input, "--01-01") then next_state <= s010010; output <= "0000001";
        elsif std_match(input, "--00-01") then next_state <= s010001; output <= "0100010";
        elsif std_match(input, "--1--01") then next_state <= s010010; output <= "0000001";
        elsif std_match(input, "-----11") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "------0") then next_state <= s001100; output <= "0100000";
        end if;
      when s010001 =>
        if std_match(input, "-----1-") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-1---01") then next_state <= s010011; output <= "0000010";
        elsif std_match(input, "-0---01") then next_state <= s010001; output <= "0000010";
        elsif std_match(input, "-----00") then next_state <= s001100; output <= "0100000";
        end if;
      when s010011 =>
        if std_match(input, "-----1-") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----01") then next_state <= s110000; output <= "0100000";
        elsif std_match(input, "-----00") then next_state <= s001100; output <= "0100000";
        end if;
      when s110000 =>
        if std_match(input, "-1---01") then next_state <= s100000; output <= "0000001";
        elsif std_match(input, "-0---01") then next_state <= s110000; output <= "0000000";
        elsif std_match(input, "-----11") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "------0") then next_state <= s001100; output <= "0100000";
        end if;
      when s100000 =>
        if std_match(input, "------0") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----11") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----01") then next_state <= s000010; output <= "0000000";
        end if;
      when s000010 =>
        if std_match(input, "-----1-") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "--10-00") then next_state <= s001100; output <= "0101000";
        elsif std_match(input, "--00-00") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "---1-00") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "---1101") then next_state <= s100000; output <= "0000001";
        elsif std_match(input, "--10101") then next_state <= s000000; output <= "0001000";
        elsif std_match(input, "--00101") then next_state <= s010001; output <= "0100010";
        elsif std_match(input, "--10001") then next_state <= s000000; output <= "0001000";
        elsif std_match(input, "--11001") then next_state <= s000010; output <= "0000000";
        elsif std_match(input, "--00001") then next_state <= s010001; output <= "0100010";
        elsif std_match(input, "--01001") then next_state <= s000010; output <= "0000000";
        end if;
      when s010000 =>
        if std_match(input, "------0") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----01") then next_state <= s000001; output <= "0000000";
        elsif std_match(input, "-----11") then next_state <= s001100; output <= "0100000";
        end if;
      when s000001 =>
        if std_match(input, "-----1-") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "-----00") then next_state <= s001100; output <= "0100000";
        elsif std_match(input, "--1--01") then next_state <= s010010; output <= "0000001";
        elsif std_match(input, "--0--01") then next_state <= s010000; output <= "0000001";
        end if;
      when others => next_state <= "-------------"; output <= "-------";
    end case;
  end process;
end behaviour;
