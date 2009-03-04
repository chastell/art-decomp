describe FSM do

  context 'parsed from an example KISS file' do

    it 'should properly report the number of inputs' do
      fsm = FSM.from_kiss 'spec/fixtures/opus'
      fsm.input_count.should == 5
    end

  end

end
