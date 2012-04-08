require_relative '../spec_helper'

module ArtDecomp describe UVRelevanceGenerator do
  let :fsm do
    fsm = MiniTest::Mock.new
    fsm.expect :input_count, 6
    fsm.expect :send, [0, 1, 2, nil, nil, nil, 3, 4, 5], [:common_relevance]
    fsm.expect :expand_x, fsm, [Set]
  end

  describe '#uv_pairs' do
    it 'yields U and V combinations in a relevance-based order' do
      uvg = UVRelevanceGenerator.new
      uvs = uvg.uv_pairs(fsm, Set[Arch[3,1]], :common_relevance).to_a

      uvs.size.must_equal 42
      uvs[0].must_equal   [fsm, Set[0,1,2], Set[3,4,5]]
      uvs[1].must_equal   [fsm, Set[0,1,2,3], Set[4,5]]
      uvs[2].must_equal   [fsm, Set[0,1,2,4], Set[3,5]]
      uvs[3].must_equal   [fsm, Set[0,1,2,5], Set[3,4]]
      uvs[4].must_equal   [fsm, Set[0,1,2,3,4], Set[5]]
      uvs[5].must_equal   [fsm, Set[0,1,2,3,5], Set[4]]
      uvs[6].must_equal   [fsm, Set[0,1,2,4,5], Set[3]]
      uvs[7].must_equal   [fsm, Set[0,1,2,3,4,5], Set[]]
      uvs[8].must_equal   [fsm, Set[0,1,3], Set[2,4,5]]
      uvs.last.must_equal [fsm, Set[3,4,5], Set[0,1,2]]
    end

    it 'considers all architecture widths when generating the UV sets' do
      uvg = UVRelevanceGenerator.new
      uvs = uvg.uv_pairs(fsm, Set[Arch[3,1], Arch[2,1]], :common_relevance).to_a

      uvs.size.must_equal 42
      uvs[0].must_equal   [fsm, Set[0,1,2,3], Set[4,5]]
      uvs[1].must_equal   [fsm, Set[0,1,2,4], Set[3,5]]
      uvs[2].must_equal   [fsm, Set[0,1,2,5], Set[3,4]]
      uvs[3].must_equal   [fsm, Set[0,1,2], Set[3,4,5]]
      uvs[4].must_equal   [fsm, Set[0,1,2,3,4], Set[5]]
      uvs[5].must_equal   [fsm, Set[0,1,2,3,5], Set[4]]
      uvs[6].must_equal   [fsm, Set[0,1,2,4,5], Set[3]]
      uvs[7].must_equal   [fsm, Set[0,1,2,3,4,5], Set[]]
      uvs[8].must_equal   [fsm, Set[0,1,3,4], Set[2,5]]
      uvs[9].must_equal   [fsm, Set[0,1,3,5], Set[2,4]]
      uvs[10].must_equal  [fsm, Set[0,1,3], Set[2,4,5]]
      uvs.last.must_equal [fsm, Set[3,4,5], Set[0,1,2]]
    end

    it 'yields V-expanded FSMs' do
      fsm = MiniTest::Mock.new
      fsm.expect :input_count, 2
      fsm.expect :send, [1, 0, nil, nil, nil], [:common_relevance]

      fsm0 = MiniTest::Mock.new
      fsm1 = MiniTest::Mock.new
      fsm2 = MiniTest::Mock.new
      fsm3 = MiniTest::Mock.new
      fsm.expect :expand_x, fsm0, [Set[]]
      fsm.expect :expand_x, fsm1, [Set[0]]
      fsm.expect :expand_x, fsm2, [Set[1]]
      fsm.expect :expand_x, fsm3, [Set[0,1]]

      uvg = UVRelevanceGenerator.new
      uvs = uvg.uv_pairs(fsm, Set[Arch[3,1]], :common_relevance).to_a

      uvs.must_equal [
        [fsm0, Set[0,1], Set[]],
        [fsm1, Set[1],   Set[0]],
        [fsm2, Set[0],   Set[1]],
        [fsm3, Set[],    Set[0,1]],
      ]
    end
  end
end end
