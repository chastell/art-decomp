module ArtDecomp describe UVGenerator::Braindead do

  context 'given a certain FSM and a Set of Archs' do

    it 'should yield all non-insane U and V combinations' do
      fsm = mock FSM, :input_count => 4
      fsm.stub!(:expand_x).and_return fsm
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Braindead.new fsm, archs
      uvs = uv_gen.uv_pairs.to_a
      uvs.size.should  == 15
      uvs.first.should == [fsm, [0,1,2,3], []]
      uvs[7].should    == [fsm, [3], [0,1,2]]
      uvs.last.should  == [fsm, [0], [1,2,3]]
    end

    it 'should yield V-expanded FSMs' do
      fsm = mock FSM, :input_count => 2
      fsm0, fsm1, fsm2, fsm3 = mock(FSM), mock(FSM), mock(FSM), mock(FSM)
      fsm.should_receive(:expand_x).exactly(4).times.and_return(fsm0, fsm1, fsm2, fsm3)
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Braindead.new fsm, archs
      uv_gen.uv_pairs.to_a.should == [
        [fsm0, [0,1], []],
        [fsm1, [1],   [0]],
        [fsm2, [0],   [1]],
        [fsm3, [],    [0,1]],
      ]
    end

  end

end end
