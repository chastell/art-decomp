# encoding: UTF-8

module ArtDecomp describe Decomposition do

  before do
    @mock_qu  = mock Blanket
    @mock_qv  = mock Blanket
    @mock_g   = mock Blanket
    @mock_fsm = mock FSM, beta_q: mock(Blanket, pins: 3), input_count: 3, output_count: 2
    @mock_dec = Decomposition.new @mock_fsm, Set[0,1], Set[2], @mock_qu, @mock_qv, @mock_g

    @b  = mock Blanket
    @b1 = mock Blanket, pins: 1, size: 2
    @b2 = mock Blanket, pins: 2, size: 4
    @b3 = mock Blanket, pins: 3
    @b4 = mock Blanket, pins: 4

    qu = Blanket[B[0,4,5], B[1,2,3,13,14], B[6,7,8,9,10,11,12], B[15,16,17,18,19]]
    qv = Blanket[B[0,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19], B[1,2,18]]
    g  = Blanket[B[0,2,5,6,7,9,11,15,16,17,18,19], B[1,3,4,8,10,12,13,14]]
    @fsm = FSM.from_kiss 'spec/fixtures/fsm'
    @dec = Decomposition.new @fsm, Set[0,1,3], Set[2], qu, qv, g
  end

  describe '#==' do

    it 'compares Decompositions based on their parts' do
      @mock_dec.should     == Decomposition.new(@mock_fsm, Set[0,1], Set[2], @mock_qu, @mock_qv, @mock_g)
      @mock_dec.should_not == Decomposition.new(@mock_fsm, Set[2], Set[0,1], @mock_qu, @mock_qv, @mock_g)
      @mock_dec.should_not == Decomposition.new(@mock_fsm, Set[0,1], Set[2], @mock_qv, @mock_qu, @mock_g)
    end

  end

  describe '#disjoint?' do

    it 'returns whether the Decomposition is disjoint' do
      Decomposition.new(@mock_fsm, Set[0],   Set[1],   @b, @b, @b).should     be_disjoint
      Decomposition.new(@mock_fsm, Set[0,1], Set[1],   @b, @b, @b).should_not be_disjoint
      Decomposition.new(@mock_fsm, Set[1],   Set[0,1], @b, @b, @b).should_not be_disjoint
    end

  end

  describe '#eql?' do

    it 'compares Decompositions for the purpose of Hash/Set use' do
      @mock_dec.should eql Decomposition.new(@mock_fsm, Set[0,1], Set[2], @mock_qu, @mock_qv, @mock_g)
    end

  end

  describe '#f_kiss' do

    it 'returns the F block’s KISS representation' do
      @dec.f_kiss.should == File.read('spec/fixtures/fsm.f')
    end

  end

  describe '#final?' do

    it 'returns whether the Decomposition is final based on a Set of Archs' do
      Decomposition.new(@mock_fsm, Set[0],   Set[1],   @b1, @b3, @b3).should     be_final Set[Arch[5,1]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1],   @b1, @b3, @b3).should_not be_final Set[Arch[4,2]]
      Decomposition.new(@mock_fsm, Set[],    Set[1],   @b1, @b3, @b3).should     be_final Set[Arch[4,2]]
      Decomposition.new(@mock_fsm, Set[],    Set[1,2], @b1, @b3, @b3).should_not be_final Set[Arch[4,2]]
      Decomposition.new(@mock_fsm, Set[],    Set[1],   @b1, @b4, @b3).should_not be_final Set[Arch[4,2]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2], @b1, @b3, @b3).should     be_final Set[Arch[5,1]]
      Decomposition.new(@mock_fsm, Set[0,1], Set[2],   @b1, @b3, @b3).should_not be_final Set[Arch[5,1]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2], @b2, @b3, @b3).should_not be_final Set[Arch[5,1]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2], @b1, @b3, @b4).should_not be_final Set[Arch[5,1]]
    end

  end

  describe '#g_cells' do

    it 'returns G cell count (if G fits the provided Archs)' do
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b, @b2, @b2).g_cells(Set[Arch[5,1]]).should == 2
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b, @b2, @b2).g_cells(Set[Arch[4,2]]).should == 1
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b, @b2, @b2).g_cells(Set[Arch[3,2]]).should be_nil
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b, @b2, @b3).g_cells(Set[Arch[4,2]]).should == 2
    end

  end

  describe '#g_kiss' do

    it 'returns the G block’s KISS representation' do
      @dec.g_kiss.should == File.read('spec/fixtures/fsm.g')
    end

  end

  describe '#h_cells' do

    it 'returns H cell count (if G fits the provided Archs)' do
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b1, @b1, @b2).h_cells(Set[Arch[5,1]]).should == 4
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b1, @b1, @b2).h_cells(Set[Arch[4,2]]).should == 2
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b1, @b1, @b2).h_cells(Set[Arch[3,1]]).should be_nil
      Decomposition.new(@mock_fsm, Set[0], Set[1,2], @b1, @b2, @b2).h_cells(Set[Arch[4,2]]).should == 3
    end

  end

  describe '#h_kiss' do

    it 'returns the H block’s KISS representation' do
      @dec.h_kiss.should == File.read('spec/fixtures/fsm.h')
    end

    it 'creates the H block properly, even if the G blanket seems ambiguous' do
      fsm = FSM.from_kiss 'spec/fixtures/opus'
      qu  = Blanket[B[0,1,11,14,15,16,17,18,19,20,30,33,34,35,36,37], B[2,5,7,14,21,24,26,33], B[3,4,10,13,14,22,23,29,32,33], B[6,8,9,12,14,25,27,28,31,33]]
      qv  = Blanket[B[0,2,6,8,10,13,14,15,19,21,25,27,29,32,33,34], B[1,3,4,5,7,9,12,14,20,22,23,24,26,28,31,33], B[11,14,16,17,18,30,33,35,36,37]]
      g   = Blanket[B[0,2,6,8,10,13,14,15,19,21,25,27,29,32,33,34], B[1,3,4,5,7,9,12,14,20,22,23,24,26,28,31,33], B[11,14,16,17,18], B[30,33,35,36,37]]
      decomposition = Decomposition.new fsm.expand_x(Set[0]), Set[1,2,3,4], Set[0], qu, qv, g
      decomposition.h_kiss.should == File.read('spec/fixtures/opus.amb.h')
    end

    it 'properly recodes don’t-care states to *' do
      fsm = FSM.from_kiss 'spec/fixtures/opus'
      qu  = Blanket[B[0,1,2,3,4,20,21], B[0,5,6,7], B[0,8,9,10,11,12,13,14,15,16], B[0,17,18,19]]
      qv  = Blanket[B[0,1,2,6,7,15,16,17,18], B[0,3,4,5,8,9,10,11,12,13,14,19], B[0,20,21]]
      g   = Blanket[B[0,1], B[2,6,7,15,16,17,18], B[3,4,5,8,9,10,11,12,13,14,19], B[20,21]]
      decomposition = Decomposition.new fsm, Set[0,1,3,4], Set[2], qu, qv, g
      decomposition.h_kiss.should == File.read('spec/fixtures/opus.h')
    end

  end

  describe '#hash' do

    it 'hashes Decompositions for the purpose of Hash/Set use' do
      @mock_dec.hash.should == Decomposition.new(@mock_fsm, Set[0,1], Set[2], @mock_qu, @mock_qv, @mock_g).hash
    end

  end

  describe '#q_kiss' do

    it 'returns the Q block’s KISS representation' do
      @dec.q_kiss.should == File.read('spec/fixtures/fsm.q')
    end

  end

  describe '#sensible?' do

    it 'returns whether it’s sensible, based on the target Archs and G and H blocks’ architectures' do
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2],   @b2, @b2, @b2).should_not be_sensible Set[Arch[3,2]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2],   @b2, @b2, @b2).should     be_sensible Set[Arch[4,1]]
      Decomposition.new(@mock_fsm, Set[],    Set[0,1,2], @b2, @b2, @b2).should_not be_sensible Set[Arch[4,1]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2],   @b2, @b3, @b2).should_not be_sensible Set[Arch[4,1]]
      Decomposition.new(@mock_fsm, Set[0,1], Set[1,2],   @b2, @b2, @b2).should_not be_sensible Set[Arch[4,1]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2],   @b3, @b2, @b2).should_not be_sensible Set[Arch[4,1]]
      Decomposition.new(@mock_fsm, Set[0],   Set[1,2],   @b2, @b2, @b3).should_not be_sensible Set[Arch[4,1]]
    end

  end

  describe '#symbolic?' do

    it 'returns whether the resulting H block is an FSM' do
      Decomposition.new(@mock_fsm, Set[0], Set[1], @b1, @b, @b).should_not be_symbolic
      Decomposition.new(@mock_fsm, Set[0], Set[1], @b2, @b, @b).should     be_symbolic
    end

  end

  describe '#valid?' do

    it 'returns the Decomposition’s validity' do
      qu  = Blanket[B[0,1,2,3,4,5,17], B[6,7,8,9,10,11,12,13,14,15,16,18,19]]
      qv  = Blanket[B[0,1,2,17,19], B[3,6,7,8,9,10,11,12], B[4,5,18], B[13,14,15,16]]
      g   = Blanket[B[0,1,4,6,17,18,19], B[2,7,9,11], B[3,5,8,10,12], B[13,14,15,16]]
      Decomposition.new(@fsm, Set[1,3], Set[0,2], qu, qv, g).should     be_valid
      Decomposition.new(@fsm, Set[1,3], Set[0,2], qv, qu, g).should_not be_valid
      Decomposition.new(@fsm, Set[1,3], Set[0,2], qv, qv, g).should_not be_valid
    end

  end

end end
