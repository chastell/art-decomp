module ArtDecomp describe FSM do

  context 'parsed from an example KISS file' do

    before do
      @fsm   = FSM.from_kiss 'spec/fixtures/fsm'
      @lion  = FSM.from_kiss 'spec/fixtures/lion'
      @mark1 = FSM.from_kiss 'spec/fixtures/mark1'
      @mc    = FSM.from_kiss 'spec/fixtures/mc'
      @opus  = FSM.from_kiss 'spec/fixtures/opus'
    end

    it 'should parse both KISS files and strings' do
      @mc.should == FSM.from_kiss(File.read 'spec/fixtures/mc')
    end

    it 'should properly report the number of inputs' do
      @opus.input_count.should == 5
      @lion.input_count.should == 2
      @mc.input_count.should   == 3
    end

    it 'should properly generate the Q Blanket' do
      @opus.beta_q.should == Blanket[B[0,1,2], B[0,3,4], B[0,5], B[0,6,7], B[0,8,9,10,11,12,13,14], B[0,15,16], B[0,17,18], B[0,19], B[0,20], B[0,21]]
      @lion.beta_q.should == Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]]
      @mc.beta_q.should   == Blanket[B[0,1,2], B[3,4], B[5,6,7], B[8,9]]
    end

    it 'should properly generate the F Blanket' do
      @opus.beta_f.should == Blanket[B[0,1], B[2,3,9], B[4,14], B[5,6], B[7,8,20,21], B[10,16], B[11,18], B[12,15], B[13,17], B[19]]
      @lion.beta_f.should == Blanket[B[0,1,4], B[2], B[2,3,7], B[5,6,10], B[8,9]]
      @mc.beta_f.should   == Blanket[B[0,1], B[2], B[3], B[4], B[5], B[6,7], B[8], B[9]]
    end

    it 'should properly generate selected inputs Blankets' do
      @mc.beta_x([0]).should   == Blanket[B[0,1,3,4,6,7,8,9], B[1,2,3,4,5,7,8,9]]
      @mc.beta_x([1,2]).should == Blanket[B[0,1,3,5,6,8], B[0,1,4,5,6,9], B[0,2,3,6,7,8], B[0,2,4,6,7,9]]
      @mc.beta_x([]).should    == Blanket[B[0,1,2,3,4,5,6,7,8,9]]
    end

    it 'should properly generate its KISS representation' do
      @opus.to_kiss.should == File.read('spec/fixtures/opus.to_kiss')
      @lion.to_kiss.should == File.read('spec/fixtures/lion.to_kiss')
      @mc.to_kiss.should   == File.read('spec/fixtures/mc.to_kiss')
    end

    it 'should return a given input’s encoding for the given row(s)' do
      @opus.x_encoding(2, B[0]).should   == '1'
      @opus.x_encoding(0, B[0]).should   == '-'
      @opus.x_encoding(0, B[7,8]).should == '0'
      lambda { @opus.x_encoding 0, B[8,9] }.should raise_error(AmbiguousEncodingQuery, 'ambiguous encoding query: block 8,9')
    end

    it 'should return output encoding for the given row(s)' do
      @opus.y_encoding(B[0]).should       == '110000'
      @opus.y_encoding(B[0,1,2,3]).should == '110000'
      lambda { @opus.y_encoding B[3,4] }.should raise_error(AmbiguousEncodingQuery, 'ambiguous encoding query: block 3,4')
      @lion.y_encoding(B[2,3]).should     == '1'
      @mark1.y_encoding(B[0]).should      == '-11---1-00------'
      @mark1.y_encoding(B[0,16]).should   == '-11---1-00100000'
    end

    it 'should return the row(s) of a state matching next-state of given row(s)' do
      @opus.state_rows_of_next_state_of(B[20,21]).should == B[8,9,10,11,12,13,14]
    end

    it 'should equal/not-equal other FSMs and hash properly' do
      @lion.should_not  == FSM.from_kiss('spec/fixtures/opus')
      @lion.should      == FSM.from_kiss('spec/fixtures/lion')
      @lion.hash.should == FSM.from_kiss('spec/fixtures/lion').hash
    end

    it 'should expand selected input columns and return a new FSM instance' do
      @lion.expand_x([0,1]).should    == FSM.from_kiss('spec/fixtures/lion.exp')
      @fsm.expand_x([0,1,2,3]).should == FSM.from_kiss('spec/fixtures/fsm.exp')
      @fsm.expand_x([0,3]).should     == FSM.from_kiss('spec/fixtures/fsm.partially-exp')
    end

    it 'should return self if asked to expand columns lacking don’t-cares' do
      opus = FSM.from_kiss 'spec/fixtures/opus.to_kiss'
      opus.expand_x([2]).should equal opus
    end

  end

end end
