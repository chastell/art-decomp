describe Decomposer do

  before do
    @fsm      = mock 'FSM'
    @archs    = Set[Arch[5,1], Arch[4,2]]
    @uv_gen   = mock 'UVGenerator'
    @qu_gen   = mock 'QuGenerator'
    @qv_gen   = mock 'QvGenerator'
    @uv_class = mock 'UVGenerator class', :new => @uv_gen
    @qu_class = mock 'QuGenerator class', :new => @qu_gen
    @qv_class = mock 'QvGenerator class', :new => @qv_gen
  end

  it 'should instantiate itself and its components properly' do
    @uv_class.should_receive(:new).with @fsm, @archs
    @qu_class.should_receive(:new).with @fsm, @archs
    @qv_class.should_receive(:new).with @fsm, @archs
    Decomposer.new :fsm => @fsm, :archs => @archs, :uv_class => @uv_class, :qu_class => @qu_class, :qv_class => @qv_class
  end

  context 'given that the three generators are working properly' do

    it 'should poll the generators and yield the resulting decompositions one by one' do
      u_a, v_a = [0,1], [2]
      u_b, v_b = [0], [1,2]
      @uv_gen.should_receive(:each).with(no_args).and_yield(u_a, v_a).and_yield(u_b, v_b)

      qu_a1 = mock('Blanket')
      qu_a2 = mock('Blanket')
      @qu_gen.should_receive(:each).with(u_a, v_a).and_yield(qu_a1).and_yield(qu_a2)

      qu_b = mock('Blanket')
      @qu_gen.should_receive(:each).with(u_b, v_b).and_yield(qu_b)

      qv_a1, g_a1 = mock('Blanket'), mock('Blanket')
      @qv_gen.should_receive(:each).with(u_a, v_a, qu_a1).and_yield(qv_a1, g_a1)

      qv_a2, g_a2 = mock('Blanket'), mock('Blanket')
      @qv_gen.should_receive(:each).with(u_a, v_a, qu_a2).and_yield(qv_a2, g_a2)

      qv_bA, g_bA = mock('Blanket'), mock('Blanket')
      qv_bB, g_bB = mock('Blanket'), mock('Blanket')
      @qv_gen.should_receive(:each).with(u_b, v_b, qu_b).and_yield(qv_bA, g_bA).and_yield(qv_bB, g_bB)

      decomposer = Decomposer.new :fsm => @fsm, :archs => @archs, :uv_class => @uv_class, :qu_class => @qu_class, :qv_class => @qv_class
      results = []
      decomposer.each { |dec| results << dec }
      results.size.should  == 4
      results.first.should == Decomposition.new(@fsm, u_a, v_a, qu_a1, qv_a1, g_a1)
      results.last.should  == Decomposition.new(@fsm, u_b, v_b, qu_b,  qv_bB, g_bB)
    end

  end

end
