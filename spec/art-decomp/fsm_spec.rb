describe FSM do

  context 'parsed from an example KISS file' do

    before do
      @opus = FSM.from_kiss 'spec/fixtures/opus'
    end

    it 'should properly report the number of inputs' do
      @opus.input_count.should == 5
    end

    it 'should properly generate the βq blanket' do
      @opus.beta_q.should == Blanket[B[0,1,2], B[0,3,4], B[0,5], B[0,6,7], B[0,8,9,10,11,12,13,14], B[0,15,16], B[0,17,18], B[0,19], B[0,20], B[0,21]]
    end

  end

end
