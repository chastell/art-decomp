require_relative '../spec_helper'

module ArtDecomp describe OldDecomposer do
  describe '.new' do
    it 'instantiates the generators' do
      uv1, uv2 = MiniTest::Mock.new, MiniTest::Mock.new
      qu1, qu2 = MiniTest::Mock.new, MiniTest::Mock.new
      qv1, qv2 = MiniTest::Mock.new, MiniTest::Mock.new
      [uv1, uv2, qu1, qu2, qv1, qv2].each { |gen| gen.expect :new, nil }
      OldDecomposer.new uv_gens: [uv1, uv2], qu_gens: [qu1, qu2], qv_gens: [qv1, qv2]
      [uv1, uv2, qu1, qu2, qv1, qv2].each { |gen| gen.verify }
    end
  end

  describe '#decompositions' do
    class StubGenerator
      def initialize sequences;  @sequences = sequences;       end
      def blankets *key, &block; @sequences[key].each(&block); end
      def uv_pairs *key, &block; @sequences[key].each(&block); end
    end

    it 'polls the generators and yields the resulting decompositions one by one' do
      fsm   = FSM.from_kiss 'spec/fixtures/fsm'
      archs = Set[Arch[5,1]]

      u_a, v_a = Set[0,1], Set[2] # for this U/V pair: two Qu generating one Qv/G pair each
      qu_a1 = Object.new; def qu_a1.pins; 2; end; def qu_a1.size; 4; end
      qv_a1 = Object.new; def qv_a1.pins; 3; end; def qv_a1.size; 5; end
      g_a1  = Object.new; def g_a1.pins;  2; end
      qu_a2 = Object.new; def qu_a2.pins; 2; end; def qu_a2.size; 4; end
      qv_a2 = Object.new; def qv_a2.pins; 3; end; def qv_a2.size; 5; end
      g_a2  = Object.new; def g_a2.pins;  2; end

      u_b, v_b = Set[0], Set[1,2] # for this U/V pair: one Qu generating two Qv/G pairs
      qu_b  = Object.new; def qu_b.pins;  2; end; def qu_b.size;  4; end
      qv_bA = Object.new; def qv_bA.pins; 3; end; def qv_bA.size; 5; end
      g_bA  = Object.new; def g_bA.pins;  2; end
      qv_bB = Object.new; def qv_bB.pins; 3; end; def qv_bB.size; 5; end
      g_bB  = Object.new; def g_bB.pins;  2; end

      uv_gen = MiniTest::Mock.new
      uv_gen.expect :new, StubGenerator.new({[fsm, archs] => [[fsm, u_a, v_a], [fsm, u_b, v_b]]})
      qu_gen = MiniTest::Mock.new
      qu_gen.expect :new, StubGenerator.new({[fsm, u_a, v_a] => [qu_a1, qu_a2],
                                             [fsm, u_b, v_b] => [qu_b]})
      qv_gen = MiniTest::Mock.new
      qv_gen.expect :new, StubGenerator.new({[fsm, u_a, v_a, qu_a1] => [[qv_a1, g_a1]],
                                             [fsm, u_a, v_a, qu_a2] => [[qv_a2, g_a2]],
                                             [fsm, u_b, v_b, qu_b]  => [[qv_bA, g_bA], [qv_bB, g_bB]]})

      decomposer = OldDecomposer.new archs: archs, fsm: fsm, uv_gens: [uv_gen], qu_gens: [qu_gen], qv_gens: [qv_gen]
      results = decomposer.decompositions.to_a
      results.size.must_equal  4
      results.first.must_equal Decomposition.new(fsm, u_a, v_a, qu_a1, qv_a1, g_a1)
      results.last.must_equal  Decomposition.new(fsm, u_b, v_b, qu_b,  qv_bB, g_bB)
    end

    it 'yields only sensible decompositions' do
      fsm    = FSM.from_kiss 'spec/fixtures/fsm'
      uv_gen = MiniTest::Mock.new; uv_gen.expect :uv_pairs, [[fsm, Set[0], Set[1]]], [FSM, Set]
      qu_gen = MiniTest::Mock.new; qu_gen.expect :blankets, [Blanket.new([])], [FSM, Set, Set]
      qv_gen = MiniTest::Mock.new; qv_gen.expect :blankets, [[Blanket.new([]), Blanket.new([])], [Blanket.new([]), Blanket.new([])]], [FSM, Set, Set, Object]
      dec_class = Class.new do
        def self.new *_
          pos = MiniTest::Mock.new; pos.expect :sensible?, true,  [Set]
          neg = MiniTest::Mock.new; neg.expect :sensible?, false, [Set]
          @decs ||= [pos, neg]
          @decs.shift
        end
      end
      uv_gens = MiniTest::Mock.new; uv_gens.expect :new, uv_gen
      qu_gens = MiniTest::Mock.new; qu_gens.expect :new, qu_gen
      qv_gens = MiniTest::Mock.new; qv_gens.expect :new, qv_gen
      decomposer = OldDecomposer.new archs: Set[Arch[4,2]], fsm: fsm, uv_gens: [uv_gens], qu_gens: [qu_gens], qv_gens: [qv_gens]
      decomposer.decompositions(dec_class: dec_class).to_a.size.must_equal 1
    end

    it 'skips re-computing elements it already computed once (unless told not to)' do
      qu1, qu2, qv, g1, g2 = Object.new, Object.new, Object.new, Object.new, Object.new
      fsm    = FSM.from_kiss 'spec/fixtures/fsm'
      uv_gen = MiniTest::Mock.new; uv_gen.expect :uv_pairs, [[fsm, Set[0], Set[1]], [fsm, Set[0], Set[1]], [fsm, Set[1], Set[0]]], [FSM, Set]
      qu_gen = MiniTest::Mock.new; qu_gen.expect :blankets, [qu1, qu1, qu2], [FSM, Set, Set]
      qv_gen = MiniTest::Mock.new; qv_gen.expect :blankets, [[qv, g1], [qv, g1], [qv, g2]], [FSM, Set, Set, Object]
      dec_class = Class.new do
        def self.new *_
          MiniTest::Mock.new.expect :sensible?, true, [Set]
        end
      end
      uv_gens = MiniTest::Mock.new; uv_gens.expect :new, uv_gen
      qu_gens = MiniTest::Mock.new; qu_gens.expect :new, qu_gen
      qv_gens = MiniTest::Mock.new; qv_gens.expect :new, qv_gen
      decomposer = OldDecomposer.new archs: Set[Arch[4,2]], fsm: fsm, uv_gens: [uv_gens], qu_gens: [qu_gens], qv_gens: [qv_gens]
      decomposer.decompositions(dec_class: dec_class).to_a.size.must_equal 8
      decomposer = OldDecomposer.new archs: Set[Arch[4,2]], fsm: fsm, uv_gens: [uv_gens], qu_gens: [qu_gens], qv_gens: [qv_gens]
      decomposer.decompositions(dec_class: dec_class, keep_seen: true).to_a.size.must_equal 27
    end

    it 'computes shallow ((u & v).size == 1) non-disjoint decompositions (if told to)' do
      qu, qv, g1, g2 = Object.new, Object.new, Object.new, Object.new
      def g1.pins; 1; end
      def g2.pins; 2; end
      fsm    = Object.new
      uv_gen = MiniTest::Mock.new; uv_gen.expect :uv_pairs, [[fsm, Set[0,1], Set[2,3]]], [Object, Set]
      qu_gen = MiniTest::Mock.new; qu_gen.expect :blankets, [qu], [Object, Set, Set]
      qv_gen = MiniTest::Mock.new; qv_gen.expect :blankets, [[qv, g2], [qv, g1]], [Object, Set, Set, Object]
      dec_class = Class.new do
        def self.new *_
          MiniTest::Mock.new.expect :sensible?, true, [Set]
        end
      end
      uv_gens = MiniTest::Mock.new; uv_gens.expect :new, uv_gen
      qu_gens = MiniTest::Mock.new; qu_gens.expect :new, qu_gen
      qv_gens = MiniTest::Mock.new; qv_gens.expect :new, qv_gen
      decomposer = OldDecomposer.new archs: Set[Arch[4,2]], fsm: fsm, uv_gens: [uv_gens], qu_gens: [qu_gens], qv_gens: [qv_gens]
      decomposer.decompositions(dec_class: dec_class, non_disjoint: true).to_a.size.must_equal 4
    end

    it 'computes deep ((u & v).size > 1) non-disjoint decompositions (if told to)' do
      qu, qv, g1, g2 = Object.new, Object.new, Object.new, Object.new
      def g1.pins; 1; end
      def g2.pins; 2; end
      fsm    = Object.new
      uv_gen = MiniTest::Mock.new; uv_gen.expect :uv_pairs, [[fsm, Set[0,1], Set[2,3]]], [Object, Set]
      qu_gen = MiniTest::Mock.new; qu_gen.expect :blankets, [qu], [Object, Set, Set]
      qv_gen = MiniTest::Mock.new; qv_gen.expect :blankets, [[qv, g2], [qv, g1]], [Object, Set, Set, Object]
      dec_class = Class.new do
        def self.new *_
          MiniTest::Mock.new.expect :sensible?, true, [Set]
        end
      end
      uv_gens = MiniTest::Mock.new; uv_gens.expect :new, uv_gen
      qu_gens = MiniTest::Mock.new; qu_gens.expect :new, qu_gen
      qv_gens = MiniTest::Mock.new; qv_gens.expect :new, qv_gen
      decomposer = OldDecomposer.new archs: Set[Arch[4,2]], fsm: fsm, uv_gens: [uv_gens], qu_gens: [qu_gens], qv_gens: [qv_gens]
      decomposer.decompositions(dec_class: dec_class, non_disjoint: true, deep_ndj: true).to_a.size.must_equal 4
    end
  end
end end
