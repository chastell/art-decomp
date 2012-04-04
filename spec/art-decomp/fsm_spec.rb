# encoding: UTF-8

require_relative '../spec_helper'

module ArtDecomp describe FSM do
  let(:ex4)     { FSM.from_kiss 'spec/fixtures/ex4'         }
  let(:fsm)     { FSM.from_kiss 'spec/fixtures/fsm'         }
  let(:jedi)    { FSM.from_kiss 'spec/fixtures/mark1.jed'   }
  let(:lion)    { FSM.from_kiss 'spec/fixtures/lion'        }
  let(:mark1)   { FSM.from_kiss 'spec/fixtures/mark1'       }
  let(:mc)      { FSM.from_kiss 'spec/fixtures/mc'          }
  let(:nova)    { FSM.from_kiss 'spec/fixtures/mark1.nov'   }
  let(:one_hot) { FSM.from_kiss 'spec/fixtures/mark1.hot'   }
  let(:opus)    { FSM.from_kiss 'spec/fixtures/opus'        }
  let(:s8)      { FSM.from_kiss 'spec/fixtures/s8'          }
  let(:tt)      { FSM.from_kiss 'spec/fixtures/truth_table' }

  describe '.from_kiss' do
    it 'parses oth KISS files and Strings' do
      string = File.read 'spec/fixtures/fsm'
      FSM.from_kiss('spec/fixtures/fsm').must_equal FSM.from_kiss string
    end

    it 'handles KISS files with arbitrary next-states' do
      FSM.from_kiss 'spec/fixtures/ex5'
    end

    it 'ignores KISS lines with don’t-care next states and outputs' do
      FSM.from_kiss('spec/fixtures/kirkman').beta_q.ints.map(&:bits).flatten.max.must_equal 366
    end

    it 'handles truth table files by faking a don’t-care state column' do
      tt.input_count.must_equal  4
      tt.output_count.must_equal 2
      tt.beta_q.must_equal       Blanket[B[0,1,2,3]]
    end

    it 'handles encoded KISS files' do
      one_hot.must_equal mark1
      nova.must_equal    mark1
      jedi.must_equal    mark1
    end
  end

  describe '#==' do
    it 'compares two FSMs' do
      lion.must_equal FSM.from_kiss 'spec/fixtures/lion'
      lion.wont_equal opus
    end
  end

  describe '#beta_f' do
    it 'returns the F Blanket' do
      opus.beta_f.must_equal Blanket[B[0,1], B[2,3,9], B[4,14], B[5,6], B[7,8,20,21], B[10,16], B[11,18], B[12,15], B[13,17], B[19]]
      lion.beta_f.must_equal Blanket[B[0,1,4], B[2], B[2,3,7], B[5,6,10], B[8,9]]
      mc.beta_f.must_equal   Blanket[B[0,1], B[2], B[3], B[4], B[5], B[6,7], B[8], B[9]]
    end
  end

  describe '#beta_q' do
    it 'returns the Q Blanket' do
      opus.beta_q.must_equal Blanket[B[0,1,2], B[0,3,4], B[0,5], B[0,6,7], B[0,8,9,10,11,12,13,14], B[0,15,16], B[0,17,18], B[0,19], B[0,20], B[0,21]]
      lion.beta_q.must_equal Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]]
      mc.beta_q.must_equal   Blanket[B[0,1,2], B[3,4], B[5,6,7], B[8,9]]
    end
  end

  describe '#beta_qp' do
    it 'returns the Q’ Blanket' do
      opus.beta_qp.must_equal Blanket[B[0,1], B[2,3,9], B[4,14], B[5,6], B[7,8,20,21], B[10,16], B[11,18], B[12,15], B[13,17], B[19]]
      lion.beta_qp.must_equal Blanket[B[0,1,4], B[2,3,7], B[5,6,10], B[8,9]]
      mc.beta_qp.must_equal   Blanket[B[0,1,9], B[2,3], B[4,5], B[6,7,8]]
    end
  end

  describe '#beta_x' do
    it 'returns the selected input Blankets' do
      mc.beta_x(Set[0]).must_equal   Blanket[B[0,1,3,4,6,7,8,9], B[1,2,3,4,5,7,8,9]]
      mc.beta_x(Set[1,2]).must_equal Blanket[B[0,1,3,5,6,8], B[0,1,4,5,6,9], B[0,2,3,6,7,8], B[0,2,4,6,7,9]]
      mc.beta_x(Set[]).must_equal    Blanket[B[0,1,2,3,4,5,6,7,8,9]]
    end

    it 'returns the full input Blanket when called without parameters' do
      mc.beta_x.must_equal Blanket[B[0,1,3,6,8], B[0,1,4,6,9], B[0,3,6,7,8], B[0,4,6,7,9], B[1,3,5,8], B[1,4,5,9], B[2,3,7,8], B[2,4,7,9]]
    end

    it 'returns the given input’s Blanket when called with a non-Enumerable' do
      mc.beta_x(0).must_equal Blanket[B[0,1,3,4,6,7,8,9], B[1,2,3,4,5,7,8,9]]
    end
  end

  describe '#beta_y' do
    it 'returns the selected output Blankets' do
      mc.beta_y(Set[4]).must_equal   Blanket[B[0,1,2,3,4,5,6,7], B[8,9]]
      mc.beta_y(Set[2,3]).must_equal Blanket[B[0,1,2], B[3,4], B[5,6,7,8,9]]
      mc.beta_y(Set[]).must_equal    Blanket[B[0,1,2,3,4,5,6,7,8,9]]
    end

    it 'returns the full output Blanket when called without parameters' do
      mc.beta_y.must_equal Blanket[B[0,1], B[2], B[3], B[4], B[5], B[6,7], B[8], B[9]]
    end

    it 'returns the given output’s Blanket when called with a non-Enumerable' do
      mc.beta_y(4).must_equal Blanket[B[0,1,2,3,4,5,6,7], B[8,9]]
    end
  end

  describe '#codes' do
    it 'returns encodings for an encoded FSM' do
      one_hot.codes.must_equal({state1: :'100000000000000', state3: :'010000000000000', state2: :'001000000000000', state0: :'000100000000000', state4: :'000010000000000', state13: :'000001000000000', state10: :'000000100000000', state9: :'000000010000000', state8: :'000000001000000', state7: :'000000000100000', state6: :'000000000010000', state5: :'000000000001000', state14: :'000000000000100', state11: :'000000000000010', state12: :'000000000000001'})
      nova.codes.must_equal({state1: :'0100', state2: :'1000', state3: :'1011', state4: :'1100', state5: :'0001', state6: :'0011', state7: :'0000', state8: :'0010', state9: :'1101', state10: :'1010', state11: :'0111', state12: :'1001', state13: :'0101', state14: :'0110', state0: :'1110'})
      jedi.codes.must_equal({state1: :'0001', state3: :'1111', state2: :'0011', state0: :'1101', state4: :'1001', state13: :'1010', state10: :'1000', state9: :'1100', state8: :'0010', state7: :'0000', state6: :'0110', state5: :'0100', state14: :'1110', state11: :'0111', state12: :'1011'})
    end
  end

  describe '#eql?' do
    it 'compares two FSMs for Hash/Set element purposes' do
      assert lion.eql? FSM.from_kiss 'spec/fixtures/lion'
    end
  end

  describe '#expand_x' do
    it 'expands selected input columns and returns a new FSM instance' do
      lion.expand_x(Set[0,1]).must_equal    FSM.from_kiss 'spec/fixtures/lion.exp'
      fsm.expand_x(Set[0,1,2,3]).must_equal FSM.from_kiss 'spec/fixtures/fsm.exp'
      fsm.expand_x(Set[0,3]).must_equal     FSM.from_kiss 'spec/fixtures/fsm.partially-exp'
    end

    it 'returns self if asked to expand columns lacking don’t-cares' do
      opus.expand_x(Set[2]).must_be_same_as opus
    end
  end

  describe '#fsm_cells' do
    it 'returns the cell count for a given Set of Archs (if it’s implementable in it)' do
      lion.fsm_cells(Set[Arch[4,1]]).must_equal 3
      lion.fsm_cells(Set[Arch[4,2]]).must_equal 2
      mc.fsm_cells(Set[Arch[4,2]]).must_be_nil
      mc.fsm_cells(Set[Arch[5,1]]).must_equal   7
      s8.fsm_cells(Set[Arch[2,1]]).must_equal   0
      s8.fsm_cells(Set[Arch[3,2]]).must_equal   0
      s8.fsm_cells(Set[Arch[4,1]]).must_equal   0
    end
  end

  describe '#general_relevance' do
    it 'returns its general input relevance, and drops irrelevant inputs' do
      ex4.general_relevance.must_equal   [nil, nil, nil, nil, 2, 1, 3, 5, 4]
      fsm.general_relevance.must_equal   [2, 1, 3, 0, nil, nil, nil, nil]
      lion.general_relevance.must_equal  [0, nil, nil, 1]
      mark1.general_relevance.must_equal [nil, nil, nil, nil, 0, 3, 2, 4, 1]
      mc.general_relevance.must_equal    [nil, nil, 2, 1, 0]
      opus.general_relevance.must_equal  [nil, nil, nil, nil, 2, 3, 4, 0, 1]
      s8.general_relevance.must_equal    [0, 3, 1, 2, nil, nil, nil]
      tt.general_relevance.must_equal    [1, 2, 3]
    end
  end

  describe '#hash' do
    it 'returns the same hash for equal FSMs' do
      lion.hash.must_equal FSM.from_kiss('spec/fixtures/lion').hash
    end
  end

  describe '#implementable_in?' do
    it 'returns whether its directly implementable in a given Set of Archs' do
      assert lion.implementable_in? Set[Arch[4,2]]
      refute mc.implementable_in?   Set[Arch[4,2]]
      assert mc.implementable_in?   Set[Arch[5,1]]
      assert s8.implementable_in?   Set[Arch[2,1]]
    end
  end

  describe '#input_count' do
    it 'returns the number of inputs' do
      opus.input_count.must_equal 5
      lion.input_count.must_equal 2
      mc.input_count.must_equal   3
    end
  end

  describe '#output_count' do
    it 'returns the number of outputs' do
      opus.output_count.must_equal 6
      lion.output_count.must_equal 1
      mc.output_count.must_equal   5
    end
  end

  describe '#q_encoding' do
    it 'returns state encoding for the given row(s)' do
      opus.q_encoding(B[1]).must_equal     'init0'
      opus.q_encoding(B[1,2]).must_equal   'init0'
      opus.q_encoding(B[0,1,2]).must_equal 'init0'
      opus.q_encoding(B[0]).must_equal     '-'
      -> { opus.q_encoding B[2,3] }.must_raise AmbiguousEncodingQuery
    end
  end

  describe '#relative_relevance' do
    it 'returns its relative input relevance, and drops irrelevant inputs' do
      ex4.relative_relevance.must_equal   [nil, nil, nil, nil, 1, 2, 3, 4, 5]
      fsm.relative_relevance.must_equal   [2, 1, 0, 3, nil, nil, nil, nil]
      lion.relative_relevance.must_equal  [0, nil, nil, 1]
      mark1.relative_relevance.must_equal [nil, nil, nil, nil, 0, 2, 3, 4, 1]
      mc.relative_relevance.must_equal    [nil, nil, 0, 1, 2]
      opus.relative_relevance.must_equal  [nil, nil, nil, nil, 2, 0, 3, 1, 4]
      s8.relative_relevance.must_equal    [0, 1, 2, nil, nil, nil]
      tt.relative_relevance.must_equal    [1, 2, 3]
    end

    it 'doesn’t break with irrelevant βq' do
      FSM.from_kiss('spec/fixtures/not').relative_relevance.must_equal [0]
    end
  end

  describe '#state_rows_of_next_state_of' do
    it 'returns the row(s) of a state matching next-state of given row(s)' do
      opus.state_rows_of_next_state_of(B[20,21]).must_equal B[0,8,9,10,11,12,13,14]
      mark1.state_rows_of_next_state_of(B[2]).must_equal    B[0,22]
    end
  end

  describe '#stats' do
    it 'returns a String with input/output/state counts' do
      fsm.stats.must_equal   '4/2+10s'
      lion.stats.must_equal  '2/1+4s'
      mark1.stats.must_equal '5/16+15s'
      mc.stats.must_equal    '3/5+4s'
      opus.stats.must_equal  '5/6+10s'
    end
  end

  describe '#structure' do
    it 'returns a Hash describing the FSM’s structure' do
      mark1.structure.to_yaml.must_equal File.read 'spec/fixtures/mark1.yml'
    end
  end

  describe '#to_kiss' do
    it 'returns its KISS representation' do
      opus.to_kiss.must_equal File.read 'spec/fixtures/opus.to_kiss'
      lion.to_kiss.must_equal File.read 'spec/fixtures/lion.to_kiss'
      mc.to_kiss.must_equal   File.read 'spec/fixtures/mc.to_kiss'
      tt.to_kiss.must_equal   File.read 'spec/fixtures/truth_table'
    end
  end

  describe '#to_vhdl' do
    it 'returns its VHDL representation' do
      fsm.to_vhdl('fsm').must_equal     File.read 'spec/fixtures/fsm.vhd'
      mark1.to_vhdl('mark1').must_equal File.read 'spec/fixtures/mark1.vhd'
    end

    it 'properly generates encoded VHDL' do
      one_hot.to_vhdl('mark1_hot').must_equal File.read 'spec/fixtures/mark1_hot.vhd'
      nova.to_vhdl('mark1_nov').must_equal    File.read 'spec/fixtures/mark1_nov.vhd'
      jedi.to_vhdl('mark1_jed').must_equal    File.read 'spec/fixtures/mark1_jed.vhd'
    end
  end

  describe '#truth_table?' do
    it 'returns whether it’s a truth table (as opposed to a full-blown FSM)' do
      assert tt.truth_table?
      refute fsm.truth_table?
    end
  end

  describe '#unique_relevance' do
    it 'returns its unique input relevance, and drops irrelevant inputs' do
      ex4.unique_relevance.must_equal   [nil, nil, nil, nil, 2, 1, 5, 4, 3]
      fsm.unique_relevance.must_equal   [2, 1, 0, 3, nil, nil, nil, nil]
      lion.unique_relevance.must_equal  [0, nil, nil, 1]
      mark1.unique_relevance.must_equal [nil, nil, nil, nil, 0, 3, 2, 4, 1]
      mc.unique_relevance.must_equal    [nil, nil, 2, 1, 0]
      opus.unique_relevance.must_equal  [2, nil, nil, nil, nil, 3, 4, 1, 0]
      s8.unique_relevance.must_equal    [nil, nil, nil]
      tt.unique_relevance.must_equal    [1, 3, 2]
    end
  end

  describe '#x_encoding' do
    it 'returns given inputs’ encoding for the given row(s)' do
      opus.x_encoding(Set[2], B[0]).must_equal   '1'
      opus.x_encoding(Set[0], B[0]).must_equal   '-'
      opus.x_encoding(Set[0], B[7,8]).must_equal '0'
      opus.x_encoding(Set[0,2], B[0]).must_equal '-1'
      -> { opus.x_encoding Set[0], B[8,9] }.must_raise AmbiguousEncodingQuery
    end
  end

  describe '#y_encoding' do
    it 'returns output encoding for the given row(s)' do
      opus.y_encoding(B[0]).must_equal       '110000'
      opus.y_encoding(B[0,1,2,3]).must_equal '110000'
      -> { opus.y_encoding B[3,4] }.must_raise AmbiguousEncodingQuery

      lion.y_encoding(B[2,3]).must_equal     '1'
      mark1.y_encoding(B[0]).must_equal      '-11---1-00------'
      mark1.y_encoding(B[0,16]).must_equal   '-11---1-00100000'
    end
  end
end end
