require_relative '../../spec_helper'

module ArtDecomp describe UVGenerator::Braindead do

  describe '#uv_pairs' do

    it 'yields all non-insane U and V combinations' do
      fsm = MiniTest::Mock.new
      fsm.expect :input_count, 4
      fsm.expect :expand_x,    fsm, [Set]
      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Braindead.new
      uvs = uv_gen.uv_pairs(fsm, archs).to_a
      uvs.size.must_equal  15
      uvs.first.must_equal [fsm, Set[0,1,2,3], Set[]]
      uvs[7].must_equal    [fsm, Set[3], Set[0,1,2]]
      uvs.last.must_equal  [fsm, Set[0], Set[1,2,3]]
    end

    it 'yields V-expanded FSMs' do
      fsm = MiniTest::Mock.new
      fsm.expect :input_count, 2

      fsm0, fsm1, fsm2, fsm3 = MiniTest::Mock.new, MiniTest::Mock.new, MiniTest::Mock.new, MiniTest::Mock.new
      fsm.expect :expand_x, fsm0, [Set[]]
      fsm.expect :expand_x, fsm1, [Set[0]]
      fsm.expect :expand_x, fsm2, [Set[1]]
      fsm.expect :expand_x, fsm3, [Set[0,1]]

      fsm0.expect :==, true, [MiniTest::Mock]
      fsm1.expect :==, true, [MiniTest::Mock]
      fsm2.expect :==, true, [MiniTest::Mock]
      fsm3.expect :==, true, [MiniTest::Mock]

      archs = Set[Arch[3,1]]
      uv_gen = UVGenerator::Braindead.new
      uv_gen.uv_pairs(fsm, archs).to_a.must_equal [
        [fsm0, Set[0,1], Set[]],
        [fsm1, Set[1],   Set[0]],
        [fsm2, Set[0],   Set[1]],
        [fsm3, Set[],    Set[0,1]],
      ]
    end

  end

end end
