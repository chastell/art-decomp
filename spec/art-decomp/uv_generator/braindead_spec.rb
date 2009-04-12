describe UVGenerator::Braindead do

  context 'given a certain FSM and a Set of Archs' do

    it 'should yield all non-insane U and V combinations' do
      fsm = mock 'FSM', :input_count => 4
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Braindead.new fsm, archs
      uvs = []
      uv_gen.each { |u, v| uvs << [u, v] }
      uvs.size.should  == 15
      uvs.first.should == [[0,1,2,3], []]
      uvs[7].should    == [[3], [0,1,2]]
      uvs.last.should  == [[0], [1,2,3]]
    end

  end

end
