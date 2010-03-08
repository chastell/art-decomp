# encoding: UTF-8

module ArtDecomp describe FSM do

  context 'parsed from an example KISS file' do

    before do
      @ex4   = FSM.from_kiss 'spec/fixtures/ex4'
      @fsm   = FSM.from_kiss 'spec/fixtures/fsm'
      @lion  = FSM.from_kiss 'spec/fixtures/lion'
      @mark1 = FSM.from_kiss 'spec/fixtures/mark1'
      @mc    = FSM.from_kiss 'spec/fixtures/mc'
      @opus  = FSM.from_kiss 'spec/fixtures/opus'
      @s8    = FSM.from_kiss 'spec/fixtures/s8'
      @tt    = FSM.from_kiss 'spec/fixtures/truth_table'
    end

    it 'should parse both KISS files and strings' do
      @mc.should == FSM.from_kiss(File.read 'spec/fixtures/mc')
    end

    it 'should handle edge cases, like KISS files with arbitrary next-states' do
      lambda { FSM.from_kiss 'spec/fixtures/ex5' }.should_not raise_error
    end

    it 'should handle truth table files by faking a don’t-care state column' do
      @tt.input_count.should  == 4
      @tt.output_count.should == 2
      @tt.beta_q.should       == Blanket[B[0,1,2,3]]
    end

    it 'should properly report the number of inputs' do
      @opus.input_count.should == 5
      @lion.input_count.should == 2
      @mc.input_count.should   == 3
    end

    it 'should properly report the number of outputs' do
      @opus.output_count.should == 6
      @lion.output_count.should == 1
      @mc.output_count.should   == 5
    end

    it 'should properly generate the Q Blanket' do
      @opus.beta_q.should == Blanket[B[0,1,2], B[0,3,4], B[0,5], B[0,6,7], B[0,8,9,10,11,12,13,14], B[0,15,16], B[0,17,18], B[0,19], B[0,20], B[0,21]]
      @lion.beta_q.should == Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]]
      @mc.beta_q.should   == Blanket[B[0,1,2], B[3,4], B[5,6,7], B[8,9]]
    end

    it 'should properly generate the Q’ Blanket' do
      @opus.beta_qp.should == Blanket[B[0,1], B[2,3,9], B[4,14], B[5,6], B[7,8,20,21], B[10,16], B[11,18], B[12,15], B[13,17], B[19]]
      @lion.beta_qp.should == Blanket[B[0,1,4], B[2,3,7], B[5,6,10], B[8,9]]
      @mc.beta_qp.should   == Blanket[B[0,1,9], B[2,3], B[4,5], B[6,7,8]]
    end

    it 'should properly generate the F Blanket' do
      @opus.beta_f.should == Blanket[B[0,1], B[2,3,9], B[4,14], B[5,6], B[7,8,20,21], B[10,16], B[11,18], B[12,15], B[13,17], B[19]]
      @lion.beta_f.should == Blanket[B[0,1,4], B[2], B[2,3,7], B[5,6,10], B[8,9]]
      @mc.beta_f.should   == Blanket[B[0,1], B[2], B[3], B[4], B[5], B[6,7], B[8], B[9]]
    end

    it 'should properly generate selected inputs Blankets' do
      @mc.beta_x(Set[0]).should   == Blanket[B[0,1,3,4,6,7,8,9], B[1,2,3,4,5,7,8,9]]
      @mc.beta_x(Set[1,2]).should == Blanket[B[0,1,3,5,6,8], B[0,1,4,5,6,9], B[0,2,3,6,7,8], B[0,2,4,6,7,9]]
      @mc.beta_x(Set[]).should    == Blanket[B[0,1,2,3,4,5,6,7,8,9]]
    end

    it 'should properly generate selected output Blankets' do
      @mc.beta_y(Set[4]).should   == Blanket[B[0,1,2,3,4,5,6,7], B[8,9]]
      @mc.beta_y(Set[2,3]).should == Blanket[B[0,1,2], B[3,4], B[5,6,7,8,9]]
      @mc.beta_y(Set[]).should    == Blanket[B[0,1,2,3,4,5,6,7,8,9]]
    end

    it 'should properly generate its KISS representation' do
      @opus.to_kiss.should == File.read('spec/fixtures/opus.to_kiss')
      @lion.to_kiss.should == File.read('spec/fixtures/lion.to_kiss')
      @mc.to_kiss.should   == File.read('spec/fixtures/mc.to_kiss')
      @tt.to_kiss.should   == File.read('spec/fixtures/truth_table')
    end

    it 'should return given inputs’ encoding for the given row(s)' do
      @opus.x_encoding(Set[2], B[0]).should   == '1'
      @opus.x_encoding(Set[0], B[0]).should   == '-'
      @opus.x_encoding(Set[0], B[7,8]).should == '0'
      lambda { @opus.x_encoding Set[0], B[8,9] }.should raise_error(AmbiguousEncodingQuery, 'ambiguous encoding query: block 8,9')
      @opus.x_encoding(Set[0,2], B[0]).should == '-1'
    end

    it 'should return output encoding for the given row(s)' do
      @opus.y_encoding(B[0]).should       == '110000'
      @opus.y_encoding(B[0,1,2,3]).should == '110000'
      lambda { @opus.y_encoding B[3,4] }.should raise_error(AmbiguousEncodingQuery, 'ambiguous encoding query: block 3,4')
      @lion.y_encoding(B[2,3]).should     == '1'
      @mark1.y_encoding(B[0]).should      == '-11---1-00------'
      @mark1.y_encoding(B[0,16]).should   == '-11---1-00100000'
    end

    it 'should return state encoding for the given row(s)' do
      @opus.q_encoding(B[1]).should     == 'init0'
      @opus.q_encoding(B[1,2]).should   == 'init0'
      @opus.q_encoding(B[0,1,2]).should == 'init0'
      @opus.q_encoding(B[0]).should     == '-'
      lambda { @opus.q_encoding B[2,3] }.should raise_error(AmbiguousEncodingQuery, 'ambiguous encoding query: block 2,3')
    end

    it 'should return the row(s) of a state matching next-state of given row(s)' do
      @opus.state_rows_of_next_state_of(B[20,21]).should == B[0,8,9,10,11,12,13,14]
      @mark1.state_rows_of_next_state_of(B[2]).should    == B[0,22]
    end

    it 'should equal/not-equal other FSMs and hash properly' do
      @lion.should_not  == FSM.from_kiss('spec/fixtures/opus')
      @lion.should      == FSM.from_kiss('spec/fixtures/lion')
      @lion.hash.should == FSM.from_kiss('spec/fixtures/lion').hash
      @lion.should     eql FSM.from_kiss('spec/fixtures/lion')
    end

    it 'should expand selected input columns and return a new FSM instance' do
      @lion.expand_x(Set[0,1]).should    == FSM.from_kiss('spec/fixtures/lion.exp')
      @fsm.expand_x(Set[0,1,2,3]).should == FSM.from_kiss('spec/fixtures/fsm.exp')
      @fsm.expand_x(Set[0,3]).should     == FSM.from_kiss('spec/fixtures/fsm.partially-exp')
    end

    it 'should return self if asked to expand columns lacking don’t-cares' do
      opus = FSM.from_kiss 'spec/fixtures/opus.to_kiss'
      opus.expand_x(Set[2]).should equal opus
    end

    it 'should report its input/output/state counts' do
      @fsm.stats.should   == '4/2+10s'
      @lion.stats.should  == '2/1+4s'
      @mark1.stats.should == '5/16+15s'
      @mc.stats.should    == '3/5+4s'
      @opus.stats.should  == '5/6+10s'
    end

    it 'should report whether its directly implementable in a given Set of Archs' do
      @lion.should   be_implementable_in Set[Arch[4,2]]
      @mc.should_not be_implementable_in Set[Arch[4,2]]
      @mc.should     be_implementable_in Set[Arch[5,1]]
      @s8.should     be_implementable_in Set[Arch[2,1]]
    end

    it 'should report the cell count for a given Set of Archs (if it’s implementable in it)' do
      @lion.fsm_cells(Set[Arch[4,1]]).should == 3
      @lion.fsm_cells(Set[Arch[4,2]]).should == 2
      @mc.fsm_cells(Set[Arch[4,2]]).should be_nil
      @mc.fsm_cells(Set[Arch[5,1]]).should   == 7
      @s8.fsm_cells(Set[Arch[2,1]]).should   == 0
      @s8.fsm_cells(Set[Arch[3,2]]).should   == 0
      @s8.fsm_cells(Set[Arch[4,1]]).should   == 0
    end

    it 'should report its general input relevance, and drop irrelevant inputs' do
      @ex4.general_relevance.should   == [nil, nil, nil, nil, 2, 1, 5, 4, 3]
      @fsm.general_relevance.should   == [2, 1, 3, 0, nil, nil, nil, nil]
      @lion.general_relevance.should  == [0, nil, nil, 1]
      @mark1.general_relevance.should == [nil, nil, nil, nil, 0, 3, 2, 4, 1]
      @mc.general_relevance.should    == [nil, nil, 2, 1, 0]
      @opus.general_relevance.should  == [nil, nil, nil, nil, 2, 3, 4, 0, 1]
      @s8.general_relevance.should    == [3, 2, 1, 0, nil, nil, nil]
      @tt.general_relevance.should    == [1, 3, 2]
    end

    it 'should report its unique input relevance, and drop irrelevant inputs' do
      @ex4.unique_relevance.should   == [nil, nil, nil, nil, 2, 1, 5, 4, 3]
      @fsm.unique_relevance.should   == [2, 1, 0, 3, nil, nil, nil, nil]
      @lion.unique_relevance.should  == [0, nil, nil, 1]
      @mark1.unique_relevance.should == [nil, nil, nil, nil, 0, 3, 2, 4, 1]
      @mc.unique_relevance.should    == [nil, nil, 2, 1, 0]
      @opus.unique_relevance.should  == [2, nil, nil, nil, nil, 3, 4, 1, 0]
      @s8.unique_relevance.should    == [nil, nil, nil]
      @tt.unique_relevance.should    == [1, 3, 2]
    end

    it 'should report whether it’s a truth table or a full-blown FSM' do
      @tt.should      be_truth_table
      @fsm.should_not be_truth_table
    end

    it 'should properly generate its structure' do
      @mark1.structure.to_yaml.should == File.read('spec/fixtures/mark1.yml')
    end

    it 'should properly generate its VHDL representation' do
      @fsm.to_vhdl('fsm').should     == File.read('spec/fixtures/fsm.vhd')
      @mark1.to_vhdl('mark1').should == File.read('spec/fixtures/mark1.vhd')
    end

  end

  context 'parsed from an encoded KISS file' do

    before do
      @one_hot = FSM.from_kiss 'spec/fixtures/mark1.hot'
      @nova    = FSM.from_kiss 'spec/fixtures/mark1.nov'
      @jedi    = FSM.from_kiss 'spec/fixtures/mark1.jed'
    end

    it 'should properly create the FSM' do
      @one_hot.should == FSM.from_kiss('spec/fixtures/mark1')
      @nova.should    == FSM.from_kiss('spec/fixtures/mark1')
      @jedi.should    == FSM.from_kiss('spec/fixtures/mark1')
    end

    it 'should properly find codes in an one-hot file' do
      @one_hot.codes.should == {:state1 => :'100000000000000', :state3 => :'010000000000000', :state2 => :'001000000000000', :state0 => :'000100000000000', :state4 => :'000010000000000', :state13 => :'000001000000000', :state10 => :'000000100000000', :state9 => :'000000010000000', :state8 => :'000000001000000', :state7 => :'000000000100000', :state6 => :'000000000010000', :state5 => :'000000000001000', :state14 => :'000000000000100', :state11 => :'000000000000010', :state12 => :'000000000000001'}
      @nova.codes.should    == {:state1 => :'0100', :state2 => :'1000', :state3 => :'1011', :state4 => :'1100', :state5 => :'0001', :state6 => :'0011', :state7 => :'0000', :state8 => :'0010', :state9 => :'1101', :state10 => :'1010', :state11 => :'0111', :state12 => :'1001', :state13 => :'0101', :state14 => :'0110', :state0 => :'1110'}
      @jedi.codes.should    == {:state1 => :'0001', :state3 => :'1111', :state2 => :'0011', :state0 => :'1101', :state4 => :'1001', :state13 => :'1010', :state10 => :'1000', :state9 => :'1100', :state8 => :'0010', :state7 => :'0000', :state6 => :'0110', :state5 => :'0100', :state14 => :'1110', :state11 => :'0111', :state12 => :'1011'}
    end

    it 'should properly generate the (encoded) VHDL' do
      @one_hot.to_vhdl('mark1_hot').should == File.read('spec/fixtures/mark1_hot.vhd')
      @nova.to_vhdl('mark1_nov').should    == File.read('spec/fixtures/mark1_nov.vhd')
      @jedi.to_vhdl('mark1_jed').should    == File.read('spec/fixtures/mark1_jed.vhd')
    end

  end

end end
