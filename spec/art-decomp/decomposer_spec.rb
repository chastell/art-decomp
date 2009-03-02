describe Decomposer do

  before do
    @fsm      = mock 'FSM'
    @archs    = Set[Arch[5,1], Arch[4,2]]
  end

  it 'should instantiate itself and its components properly' do
    @uv_class = mock 'UVGenerator class'
    @qu_class = mock 'QuGenerator class'
    @qv_class = mock 'QvGenerator class'
    @uv_class.should_receive(:new).with @fsm, @archs
    @qu_class.should_receive(:new).with @fsm, @archs
    @qv_class.should_receive(:new).with @fsm, @archs
    Decomposer.new :fsm => @fsm, :archs => @archs, :uv_class => @uv_class, :qu_class => @qu_class, :qv_class => @qv_class
  end

  context 'given that the three generators are working properly' do

    class StubGenerator
      def initialize sequences
        @sequences = sequences
      end
      def each *key, &block
        @sequences[key].each &block
      end
    end

    it 'should poll the generators and yield the resulting decompositions one by one' do
      u_a, v_a = [0,1], [2] # for this U/V pair: two Qu generating one Qv/G pair each
      qu_a1, qv_a1, g_a1 = mock('Blanket'), mock('Blanket'), mock('Blanket')
      qu_a2, qv_a2, g_a2 = mock('Blanket'), mock('Blanket'), mock('Blanket')

      u_b, v_b = [0], [1,2] # for this U/V pair: one Qu generating two Qv/G pairs
      qu_b = mock('Blanket')
      qv_bA, g_bA = mock('Blanket'), mock('Blanket')
      qv_bB, g_bB = mock('Blanket'), mock('Blanket')

      @uv_class = mock 'UVGenerator class', :new => StubGenerator.new({[] => [[u_a, v_a], [u_b, v_b]]})
      @qu_class = mock 'QuGenerator class', :new => StubGenerator.new({[u_a, v_a] => [qu_a1, qu_a2],
                                                                       [u_b, v_b] => [qu_b]})
      @qv_class = mock 'QvGenerator class', :new => StubGenerator.new({[u_a, v_a, qu_a1] => [[qv_a1, g_a1]],
                                                                       [u_a, v_a, qu_a2] => [[qv_a2, g_a2]],
                                                                       [u_b, v_b, qu_b]  => [[qv_bA, g_bA], [qv_bB, g_bB]]})

      decomposer = Decomposer.new :fsm => @fsm, :archs => @archs, :uv_class => @uv_class, :qu_class => @qu_class, :qv_class => @qv_class
      results = []
      decomposer.each { |dec| results << dec }
      results.size.should  == 4
      results.first.should == Decomposition.new(@fsm, u_a, v_a, qu_a1, qv_a1, g_a1)
      results.last.should  == Decomposition.new(@fsm, u_b, v_b, qu_b,  qv_bB, g_bB)
    end

  end

end
