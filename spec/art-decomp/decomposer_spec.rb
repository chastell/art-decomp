module ArtDecomp describe Decomposer do

  it 'should instantiate itself and its components properly' do
    fsm      = mock FSM
    archs    = Set[Arch[5,1], Arch[4,2]]
    uv1, uv2 = mock('UVGenerator class'), mock('UVGenerator class')
    qu1, qu2 = mock('QuGenerator class'), mock('QuGenerator class')
    qv1, qv2 = mock('QvGenerator class'), mock('QvGenerator class')
    [uv1, uv2].each           { |gen| gen.should_receive(:new).with fsm, archs }
    [qu1, qu2, qv1, qv2].each { |gen| gen.should_receive(:new).with no_args }
    Decomposer.new :fsm => fsm, :archs => archs, :uv_gens => [uv1, uv2], :qu_gens => [qu1, qu2], :qv_gens => [qv1, qv2]
  end

  context 'given that the three generators are working properly' do

    class StubGenerator
      attr_reader :class
      def initialize klass, sequences
        @class, @sequences = klass, sequences
      end
      def elems *key, &block
        @sequences[key].each &block
      end
      alias uv_pairs elems
      alias blankets elems
    end

    it 'should poll the generators and yield the resulting decompositions one by one' do
      fsm = mock FSM, :beta_q => mock(Blanket, :pins => 3, :size => 5), :input_count => 4

      u_a, v_a = [0,1], [2] # for this U/V pair: two Qu generating one Qv/G pair each
      qu_a1, qv_a1, g_a1 = mock(Blanket, :pins => 2, :size => 4), mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)
      qu_a2, qv_a2, g_a2 = mock(Blanket, :pins => 2, :size => 4), mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)

      u_b, v_b = [0], [1,2] # for this U/V pair: one Qu generating two Qv/G pairs
      qu_b = mock Blanket, :pins => 2, :size => 4
      qv_bA, g_bA = mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)
      qv_bB, g_bB = mock(Blanket, :pins => 3, :size => 5), mock(Blanket, :pins => 2)

      uv_gen = mock UVGenerator::Braindead,      :new => StubGenerator.new(UVGenerator::Braindead,      {[] => [[fsm, u_a, v_a], [fsm, u_b, v_b]]})
      qu_gen = mock QuGenerator::BlockTable,     :new => StubGenerator.new(QuGenerator::BlockTable,     {[fsm, u_a, v_a] => [qu_a1, qu_a2],
                                                                                                         [fsm, u_b, v_b] => [qu_b]})
      qv_gen = mock QvGenerator::GraphColouring, :new => StubGenerator.new(QvGenerator::GraphColouring, {[fsm, u_a, v_a, qu_a1] => [[qv_a1, g_a1]],
                                                                                                         [fsm, u_a, v_a, qu_a2] => [[qv_a2, g_a2]],
                                                                                                         [fsm, u_b, v_b, qu_b]  => [[qv_bA, g_bA], [qv_bB, g_bB]]})

      decomposer = Decomposer.new :archs => Set[Arch[5,1]], :fsm => fsm, :uv_gens => [uv_gen], :qu_gens => [qu_gen], :qv_gens => [qv_gen]
      results = decomposer.decompositions.to_a
      results.size.should  == 4
      results.first.should == Decomposition.new(fsm, u_a, v_a, qu_a1, qv_a1, g_a1)
      results.last.should  == Decomposition.new(fsm, u_b, v_b, qu_b,  qv_bB, g_bB)
      results.sample.uv_gen.should == UVGenerator::Braindead
      results.sample.qu_gen.should == QuGenerator::BlockTable
      results.sample.qv_gen.should == QvGenerator::GraphColouring
    end

    it 'should yield only sensible decompositions' do
      fsm    = mock FSM
      uv_gen = mock UVGenerator,   :uv_pairs  => [[fsm, [0], [1]]]
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
      uv_gen = mock UVGenerator, :uv_pairs => [[fsm, [0], [1]], [fsm, [0], [1]], [fsm, [1], [0]]]
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

    it 'should compute non-disjoint decompositions (if told to)' do
      qu, qv, g1, g2 = mock(Blanket), mock(Blanket), mock(Blanket, :pins => 1), mock(Blanket, :pins => 2)
      fsm    = mock FSM
      uv_gen = mock UVGenerator, :uv_pairs => [[fsm, [0], [1]]]
      qu_gen = mock QuGenerator, :blankets => [qu]
      qv_gen = mock QvGenerator, :blankets => [[qv, g1], [qv, g2]]
      dec    = mock Decomposition, :sensible? => true
      Decomposition.should_receive(:new).exactly(6).times.and_return dec
      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [mock('UVG', :new => uv_gen)], :qu_gens => [mock('QuG', :new => qu_gen)], :qv_gens => [mock('QvG', :new => qv_gen)]
      decs = decomposer.decompositions(:non_disjoint => true).to_a
    end

  end

end end
