describe FSM do

  context 'parsed from an example KISS file' do

    before do
      @opus = FSM.from_kiss 'spec/fixtures/opus'
    end

    it 'should properly report the number of inputs' do
      @opus.input_count.should == 5
    end

  end

end
