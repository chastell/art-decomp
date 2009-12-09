module ArtDecomp describe Decomposer do

  it 'should instantiate itself and its components properly' do
    fsm      = mock FSM
    archs    = Set[Arch[5,1], Arch[4,2]]
    uv1, uv2 = mock('UVGenerator class'), mock('UVGenerator class')
    qu1, qu2 = mock('QuGenerator class'), mock('QuGenerator class')
    qv1, qv2 = mock('QvGenerator class'), mock('QvGenerator class')
    [uv1, uv2, qu1, qu2, qv1, qv2].each { |gen| gen.should_receive(:new).with no_args }
    Decomposer.new :fsm => fsm, :archs => archs, :uv_gens => [uv1, uv2], :qu_gens => [qu1, qu2], :qv_gens => [qv1, qv2]
  end

  context 'given that the three generators are working properly' do

    class StubGenerator
      def initialize sequences
        @sequences = sequences
      end
      def elems *key, &block
        @sequences[key].each &block
      end
      alias uv_pairs elems
      alias blankets elems
    end

    it 'should poll the generators and yield the resulting decompositions one by one' do
      fsm = mock FSM, :beta_q => mock(Blanket, :pins => 3, :size => 5), :input_count => 4
      archs = Set[Arch[5,1]]

      u_a, v_a = Set[0,1], Set[2] # for this U/V pair: two Qu generating one Qv/G pair each
      qu_a1, qv_a1, g_a1 = mock(Blanket, :pins => 2, :size => 4), mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)
      qu_a2, qv_a2, g_a2 = mock(Blanket, :pins => 2, :size => 4), mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)

      u_b, v_b = Set[0], Set[1,2] # for this U/V pair: one Qu generating two Qv/G pairs
      qu_b = mock Blanket, :pins => 2, :size => 4
      qv_bA, g_bA = mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)
      qv_bB, g_bB = mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)

      uv_gen = mock UVGenerator, :new => StubGenerator.new({[fsm, archs] => [[fsm, u_a, v_a], [fsm, u_b, v_b]]})
      qu_gen = mock QuGenerator, :new => StubGenerator.new({[fsm, u_a, v_a] => [qu_a1, qu_a2],
                                                            [fsm, u_b, v_b] => [qu_b]})
      qv_gen = mock QvGenerator, :new => StubGenerator.new({[fsm, u_a, v_a, qu_a1] => [[qv_a1, g_a1]],
                                                            [fsm, u_a, v_a, qu_a2] => [[qv_a2, g_a2]],
                                                            [fsm, u_b, v_b, qu_b]  => [[qv_bA, g_bA], [qv_bB, g_bB]]})

      decomposer = Decomposer.new :archs => archs, :fsm => fsm, :uv_gens => [uv_gen], :qu_gens => [qu_gen], :qv_gens => [qv_gen]
      results = decomposer.decompositions.to_a
      results.size.should  == 4
      results.first.should == Decomposition.new(fsm, u_a, v_a, qu_a1, qv_a1, g_a1)
      results.last.should  == Decomposition.new(fsm, u_b, v_b, qu_b,  qv_bB, g_bB)
    end

    it 'should yield only sensible decompositions' do
      fsm    = mock FSM
      uv_gen = mock UVGenerator,   :uv_pairs  => [[fsm, Set[0], Set[1]]]
      qu_gen = mock QuGenerator,   :blankets  => [mock(Blanket)]
      qv_gen = mock QvGenerator,   :blankets  => [[mock(Blanket), mock(Blanket)], [mock(Blanket), mock(Blanket)]]
      dec1   = mock Decomposition, :sensible? => true
      dec2   = mock Decomposition, :sensible? => false
      Decomposition.should_receive(:new).exactly(2).times.and_return dec1, dec2
      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [mock('UVG', :new => uv_gen)], :qu_gens => [mock('QuG', :new => qu_gen)], :qv_gens => [mock('QvG', :new => qv_gen)]
      decomposer.decompositions.to_a.should == [dec1]
    end

    it 'should skip re-computing elements it already computed once (unless told not to)' do
      qu1, qu2, qv, g1, g2 = mock(Blanket), mock(Blanket), mock(Blanket), mock(Blanket), mock(Blanket)
      fsm    = mock FSM
      uv_gen = mock UVGenerator, :uv_pairs => [[fsm, Set[0], Set[1]], [fsm, Set[0], Set[1]], [fsm, Set[1], Set[0]]]
      qu_gen = mock QuGenerator, :blankets => [qu1, qu1, qu2]
      qv_gen = mock QvGenerator, :blankets => [[qv, g1], [qv, g1], [qv, g2]]
      dec    = mock Decomposition, :sensible? => true
      Decomposition.should_receive(:new).exactly(8).times.and_return dec
      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [mock('UVG', :new => uv_gen)], :qu_gens => [mock('QuG', :new => qu_gen)], :qv_gens => [mock('QvG', :new => qv_gen)]
      decomposer.decompositions.to_a.size.should == 8
      Decomposition.should_receive(:new).exactly(27).times.and_return dec
      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [mock('UVG', :new => uv_gen)], :qu_gens => [mock('QuG', :new => qu_gen)], :qv_gens => [mock('QvG', :new => qv_gen)]
      decomposer.decompositions(:keep_seen => true).to_a.size.should == 27
    end

    it 'should compute shallow ((u & v).size == 1) non-disjoint decompositions (if told to)' do
      qu, qv, g1, g2 = mock(Blanket), mock(Blanket), mock(Blanket, :pins => 1), mock(Blanket, :pins => 2)
      fsm    = mock FSM
      uv_gen = mock UVGenerator, :uv_pairs => [[fsm, Set[0,1], Set[2,3]]]
      qu_gen = mock QuGenerator, :blankets => [qu]
      qv_gen = mock QvGenerator, :blankets => [[qv, g2], [qv, g1]]
      dec    = mock Decomposition, :sensible? => true
      Decomposition.should_receive(:new).exactly(6).times.and_return dec
      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [mock('UVG', :new => uv_gen)], :qu_gens => [mock('QuG', :new => qu_gen)], :qv_gens => [mock('QvG', :new => qv_gen)]
      decomposer.decompositions(:non_disjoint => true).to_a.size.should == 4
    end

    it 'should compute deep ((u & v).size > 1) non-disjoint decompositions (if told to)' do
      qu, qv, g1, g2 = mock(Blanket), mock(Blanket), mock(Blanket, :pins => 1), mock(Blanket, :pins => 2)
      fsm    = mock FSM
      uv_gen = mock UVGenerator, :uv_pairs => [[fsm, Set[0,1], Set[2,3]]]
      qu_gen = mock QuGenerator, :blankets => [qu]
      qv_gen = mock QvGenerator, :blankets => [[qv, g2], [qv, g1]]
      dec    = mock Decomposition, :sensible? => true
      Decomposition.should_receive(:new).exactly(8).times.and_return dec
      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [mock('UVG', :new => uv_gen)], :qu_gens => [mock('QuG', :new => qu_gen)], :qv_gens => [mock('QvG', :new => qv_gen)]
      decomposer.decompositions(:non_disjoint => true, :deep_ndj => true).to_a.size.should == 4
    end

  end

end end
