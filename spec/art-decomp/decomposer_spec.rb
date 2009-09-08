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
      alias uv_pairs    elems
      alias qu_blankets elems
      alias blankets    elems
    end

    it 'should poll the generators and yield the resulting decompositions one by one' do
      fsm = mock FSM

      u_a, v_a = [0,1], [2] # for this U/V pair: two Qu generating one Qv/G pair each
      qu_a1, qv_a1, g_a1 = mock(Blanket), mock(Blanket, :pins => 3), mock(Blanket, :pins => 2)
      qu_a2, qv_a2, g_a2 = mock(Blanket), mock(Blanket, :pins => 3), mock(Blanket, :pins => 2)

      u_b, v_b = [0], [1,2] # for this U/V pair: one Qu generating two Qv/G pairs
      qu_b = mock Blanket
      qv_bA, g_bA = mock(Blanket, :pins => 3), mock(Blanket, :pins => 2)
      qv_bB, g_bB = mock(Blanket, :pins => 3), mock(Blanket, :pins => 2)

      uv_gen = mock UVGenerator::Braindead,      :new => StubGenerator.new(UVGenerator::Braindead,      {[] => [[fsm, u_a, v_a], [fsm, u_b, v_b]]})
      qu_gen = mock QuGenerator::BlockTable,     :new => StubGenerator.new(QuGenerator::BlockTable,     {[fsm, u_a, v_a] => [qu_a1, qu_a2],
                                                                                                         [fsm, u_b, v_b] => [qu_b]})
      qv_gen = mock QvGenerator::GraphColouring, :new => StubGenerator.new(QvGenerator::GraphColouring, {[fsm, u_a, v_a, qu_a1] => [[qv_a1, g_a1]],
                                                                                                         [fsm, u_a, v_a, qu_a2] => [[qv_a2, g_a2]],
                                                                                                         [fsm, u_b, v_b, qu_b]  => [[qv_bA, g_bA], [qv_bB, g_bB]]})

      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [uv_gen], :qu_gens => [qu_gen], :qv_gens => [qv_gen]
      results = decomposer.decompositions.to_a
      results.size.should  == 4
      results.first.should == Decomposition.new(fsm, u_a, v_a, qu_a1, qv_a1, g_a1)
      results.last.should  == Decomposition.new(fsm, u_b, v_b, qu_b,  qv_bB, g_bB)
      results.sample.uv_gen.should == UVGenerator::Braindead
      results.sample.qu_gen.should == QuGenerator::BlockTable
      results.sample.qv_gen.should == QvGenerator::GraphColouring
    end

    it 'should yield only sensible decompositions' do
      fsm = mock FSM
      qu, qv, g1, g2 = mock(Blanket), mock(Blanket), mock(Blanket), mock(Blanket)
      uv_gen = mock UVGenerator::Braindead,      :new => StubGenerator.new(UVGenerator::Braindead,      {[] => [[fsm, [0], [1]]]})
      qu_gen = mock QuGenerator::BlockTable,     :new => StubGenerator.new(QuGenerator::BlockTable,     {[fsm, [0], [1]] => [qu]})
      qv_gen = mock QvGenerator::GraphColouring, :new => StubGenerator.new(QvGenerator::GraphColouring, {[fsm, [0], [1], qu] => [[qv, g1], [qv, g2]]})
      dec1 = mock Decomposition, :sensible? => true
      dec2 = mock Decomposition, :sensible? => false
      Decomposition.should_receive(:new).exactly(2).times.and_return dec1, dec2
      decomposer = Decomposer.new :fsm => fsm, :uv_gens => [uv_gen], :qu_gens => [qu_gen], :qv_gens => [qv_gen]
      decomposer.decompositions.to_a.should == [dec1]
    end

  end

end end
