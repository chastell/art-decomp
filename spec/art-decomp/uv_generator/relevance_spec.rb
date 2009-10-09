module ArtDecomp describe UVGenerator::Relevance do

  context 'given a certain FSM and a Set of Archs' do

    it 'should yield U and V combinations in a relevance-based order' do
      fsm = mock FSM, :input_count => 6, :input_relevance => [0, 1, 2, nil, nil, nil, 3, 4, 5]
      fsm.stub!(:expand_x).and_return fsm
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Relevance.new fsm, archs
      uvs = uv_gen.uv_pairs.to_a
      uvs.size.should  == 42
      uvs[0].should    == [fsm, [0,1,2], [3,4,5]]
      uvs[1].should    == [fsm, [0,1,2,3], [4,5]]
      uvs[2].should    == [fsm, [0,1,2,4], [3,5]]
      uvs[3].should    == [fsm, [0,1,2,5], [3,4]]
      uvs[4].should    == [fsm, [0,1,2,3,4], [5]]
      uvs[5].should    == [fsm, [0,1,2,3,5], [4]]
      uvs[6].should    == [fsm, [0,1,2,4,5], [3]]
      uvs[7].should    == [fsm, [0,1,2,3,4,5], []]
      uvs[8].should    == [fsm, [0,1,3], [2,4,5]]
      uvs.last.should  == [fsm, [3,4,5], [0,1,2]]
    end

    it 'should yield V-expanded FSMs' do
      fsm = mock FSM, :input_count => 2, :input_relevance => [1, 0, nil, nil, nil]
      fsm0, fsm1, fsm2, fsm3 = mock(FSM), mock(FSM), mock(FSM), mock(FSM)
      fsm.should_receive(:expand_x).exactly(4).times.and_return(fsm0, fsm1, fsm2, fsm3)
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Relevance.new fsm, archs
      uv_gen.uv_pairs.to_a.should == [
        [fsm0, [0,1], []],
        [fsm1, [1],   [0]],
        [fsm2, [0],   [1]],
        [fsm3, [],    [0,1]],
      ]
    end

  end

end end
