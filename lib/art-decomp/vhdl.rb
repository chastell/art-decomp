module ArtDecomp
  class VHDL
    def initialize(fsm)
      @fsm = fsm
    end

    def vhdl(name) # rubocop:disable CyclomaticComplexity, MethodLength, PerceivedComplexity
      structure = @fsm.structure
      logic = structure[DontCare].map do |input, results|
        results[:next_state] = "s#{results[:next_state]}".to_sym if results[:next_state] =~ /^\d+$/
        [
          "    if std_match(input, \"#{input}\") then next_state <= #{results[:next_state]}; output <= \"#{results[:output]}\";",
          '    else',
        ]
      end
      structure.delete DontCare
      logic << '    case current_state is'
      logic += structure.map do |state, transitions|
        state = "s#{state}".to_sym if state =~ /^\d+$/
        [
          "      when #{state} =>",
          transitions.map.with_index do |(input, results), i|
            results[:next_state] = "s#{results[:next_state]}".to_sym if results[:next_state] =~ /^\d+$/
            "        #{'els' if i > 0}if std_match(input, \"#{input}\") then next_state <= #{results[:next_state]}; output <= \"#{results[:output]}\";" # rubocop:disable NumericPredicate
          end,
          '        end if;',
        ]
      end
      logic << "      when others => next_state <= \"#{'-' * @fsm.codes.values.first.size}\"; output <= \"#{'-' * structure.first.last.first.last[:output].size}\";" unless @fsm.codes.empty?
      logic << '    end case;'
      logic << '    end if;' if logic.flatten.include? '    else'
      if @fsm.codes.empty?
        states = [
          "  type state is (#{structure.keys.join ', '});",
          '  signal current_state, next_state: state;',
        ]
        default_state = structure.keys.first
      else
        states = @fsm.codes.map do |state, code|
          state = "s#{state}".to_sym if state =~ /^\d+$/
          "  constant #{state}: std_logic_vector(#{code.size - 1} downto 0) := \"#{code}\";"
        end
        states << "  signal current_state, next_state: std_logic_vector(#{@fsm.codes.first.last.size - 1} downto 0);"
        default_state = "\"#{'-' * @fsm.codes.values.first.size}\""
      end
      <<~VHDL
        library ieee;
        use ieee.numeric_std.all;
        use ieee.std_logic_1164.all;
        entity #{name} is
          port(
            clock:  in  std_logic;
            input:  in  std_logic_vector(#{structure.first.last.first.first.size - 1} downto 0);
            output: out std_logic_vector(#{structure.first.last.first.last[:output].size - 1} downto 0)
          );
        end #{name};
        architecture behaviour of #{name} is
        #{states.join "\n"}
        begin
          process(clock) begin
            if rising_edge(clock) then current_state <= next_state;
            end if;
          end process;
          process(input, current_state) begin
            next_state <= #{default_state}; output <= "#{'-' * structure.first.last.first.last[:output].size}";
        #{logic.join "\n"}
          end process;
        end behaviour;
      VHDL
    end
  end
end
