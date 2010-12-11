module ArtDecomp describe UVGenerator::Braindead do

  describe '#uv_pairs' do

    it 'yields all non-insane U and V combinations' do
      fsm = mock FSM, input_count: 4
      fsm.stub!(:expand_x).and_return fsm
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Braindead.new
      uvs = uv_gen.uv_pairs(fsm, archs).to_a
      uvs.size.should  == 15
      uvs.first.should == [fsm, Set[0,1,2,3], Set[]]
      uvs[7].should    == [fsm, Set[3], Set[0,1,2]]
      uvs.last.should  == [fsm, Set[0], Set[1,2,3]]
    end

    it 'yields V-expanded FSMs' do
      fsm = mock FSM, input_count: 2
      fsm0, fsm1, fsm2, fsm3 = mock(FSM), mock(FSM), mock(FSM), mock(FSM)
      fsm.should_receive(:expand_x).exactly(4).times.and_return(fsm0, fsm1, fsm2, fsm3)
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Braindead.new
      uv_gen.uv_pairs(fsm, archs).to_a.should == [
        [fsm0, Set[0,1], Set[]],
        [fsm1, Set[1],   Set[0]],
        [fsm2, Set[0],   Set[1]],
        [fsm3, Set[],    Set[0,1]],
      ]
    end

  end

end end
