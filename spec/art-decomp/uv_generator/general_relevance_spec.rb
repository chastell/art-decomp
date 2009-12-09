module ArtDecomp describe UVGenerator::GeneralRelevance do

  context 'given a certain FSM and a Set of Archs' do

    it 'should yield U and V combinations in a relevance-based order' do
      fsm = mock FSM, :input_count => 6, :general_relevance => [0, 1, 2, nil, nil, nil, 3, 4, 5]
      fsm.stub!(:expand_x).and_return fsm
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::GeneralRelevance.new
      uvs = uv_gen.uv_pairs(fsm, archs).to_a
      uvs.size.should == 42
      uvs[0].should   == [fsm, Set[0,1,2], Set[3,4,5]]
      uvs[1].should   == [fsm, Set[0,1,2,3], Set[4,5]]
      uvs[2].should   == [fsm, Set[0,1,2,4], Set[3,5]]
      uvs[3].should   == [fsm, Set[0,1,2,5], Set[3,4]]
      uvs[4].should   == [fsm, Set[0,1,2,3,4], Set[5]]
      uvs[5].should   == [fsm, Set[0,1,2,3,5], Set[4]]
      uvs[6].should   == [fsm, Set[0,1,2,4,5], Set[3]]
      uvs[7].should   == [fsm, Set[0,1,2,3,4,5], Set[]]
      uvs[8].should   == [fsm, Set[0,1,3], Set[2,4,5]]
      uvs.last.should == [fsm, Set[3,4,5], Set[0,1,2]]
    end

    it 'should consider all architecture widths when generating the UV sets' do
      fsm = mock FSM, :input_count => 6, :general_relevance => [0, 1, 2, nil, nil, nil, 3, 4, 5]
      fsm.stub!(:expand_x).and_return fsm
      archs = Set[Arch[3,1], Arch[2,1]]
      uv_gen = UVGenerator::GeneralRelevance.new
      uvs = uv_gen.uv_pairs(fsm, archs).to_a
      uvs.size.should == 42
      uvs[0].should   == [fsm, Set[0,1,2,3], Set[4,5]]
      uvs[1].should   == [fsm, Set[0,1,2,4], Set[3,5]]
      uvs[2].should   == [fsm, Set[0,1,2,5], Set[3,4]]
      uvs[3].should   == [fsm, Set[0,1,2], Set[3,4,5]]
      uvs[4].should   == [fsm, Set[0,1,2,3,4], Set[5]]
      uvs[5].should   == [fsm, Set[0,1,2,3,5], Set[4]]
      uvs[6].should   == [fsm, Set[0,1,2,4,5], Set[3]]
      uvs[7].should   == [fsm, Set[0,1,2,3,4,5], Set[]]
      uvs[8].should   == [fsm, Set[0,1,3,4], Set[2,5]]
      uvs[9].should   == [fsm, Set[0,1,3,5], Set[2,4]]
      uvs[10].should  == [fsm, Set[0,1,3], Set[2,4,5]]
      uvs.last.should == [fsm, Set[3,4,5], Set[0,1,2]]
    end

    it 'should yield V-expanded FSMs' do
      fsm = mock FSM, :input_count => 2, :general_relevance => [1, 0, nil, nil, nil]
      fsm0, fsm1, fsm2, fsm3 = mock(FSM), mock(FSM), mock(FSM), mock(FSM)
      fsm.should_receive(:expand_x).exactly(4).times.and_return(fsm0, fsm1, fsm2, fsm3)
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::GeneralRelevance.new
      uv_gen.uv_pairs(fsm, archs).to_a.should == [
        [fsm0, Set[0,1], Set[]],
        [fsm1, Set[1],   Set[0]],
        [fsm2, Set[0],   Set[1]],
        [fsm3, Set[],    Set[0,1]],
      ]
    end

  end

end end
