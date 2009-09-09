# encoding: UTF-8

module ArtDecomp describe Decomposition do

  it 'should instantiate, compare and hash properly' do
    fsm = mock FSM
    u, v = [0,1], [2]
    qu, qv, g = mock(Blanket), mock(Blanket), mock(Blanket)
    dec = Decomposition.new fsm, u, v, qu, qv, g
    dec.should      == Decomposition.new(fsm, u, v, qu, qv, g)
    dec.should_not  == Decomposition.new(fsm, v, u, qu, qv, g)
    dec.should_not  == Decomposition.new(fsm, u, v, qv, qu, g)
    dec.hash.should == Decomposition.new(fsm, u, v, qu, qv, g).hash
    dec.should     eql Decomposition.new(fsm, u, v, qu, qv, g)
  end

  it 'should create its F, Q, G and H blocks’ KISS representations properly' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    qu  = Blanket[B[0,4,5], B[1,2,3,13,14], B[6,7,8,9,10,11,12], B[15,16,17,18,19]]
    qv  = Blanket[B[0,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19], B[1,2,18]]
    g   = Blanket[B[0,2,5,6,7,9,11,15,16,17,18,19], B[1,3,4,8,10,12,13,14]]
    decomposition = Decomposition.new fsm, [0,1,3], [2], qu, qv, g
    decomposition.f_kiss.should == File.read('spec/fixtures/fsm.f')
    decomposition.q_kiss.should == File.read('spec/fixtures/fsm.q')
    decomposition.g_kiss.should == File.read('spec/fixtures/fsm.g')
    decomposition.h_kiss.should == File.read('spec/fixtures/fsm.h')
  end

  it 'should create the H block properly, even if the G blanket seems ambiguous' do
    fsm = FSM.from_kiss 'spec/fixtures/opus'
    qu  = Blanket[B[0,1,11,14,15,16,17,18,19,20,30,33,34,35,36,37], B[2,5,7,14,21,24,26,33], B[3,4,10,13,14,22,23,29,32,33], B[6,8,9,12,14,25,27,28,31,33]]
    qv  = Blanket[B[0,2,6,8,10,13,14,15,19,21,25,27,29,32,33,34], B[1,3,4,5,7,9,12,14,20,22,23,24,26,28,31,33], B[11,14,16,17,18,30,33,35,36,37]]
    g   = Blanket[B[0,2,6,8,10,13,14,15,19,21,25,27,29,32,33,34], B[1,3,4,5,7,9,12,14,20,22,23,24,26,28,31,33], B[11,14,16,17,18], B[30,33,35,36,37]]
    decomposition = Decomposition.new fsm.expand_x([0]), [1,2,3,4], [0], qu, qv, g
    decomposition.h_kiss.should == File.read('spec/fixtures/opus.amb.h')
  end

  it 'should properly recode don’t-care states to *' do
    fsm = FSM.from_kiss 'spec/fixtures/opus'
    qu  = Blanket[B[0,1,2,3,4,20,21], B[0,5,6,7], B[0,8,9,10,11,12,13,14,15,16], B[0,17,18,19]]
    qv  = Blanket[B[0,1,2,6,7,15,16,17,18], B[0,3,4,5,8,9,10,11,12,13,14,19], B[0,20,21]]
    g   = Blanket[B[0,1], B[2,6,7,15,16,17,18], B[3,4,5,8,9,10,11,12,13,14,19], B[20,21]]
    decomposition = Decomposition.new fsm, [0,1,3,4], [2], qu, qv, g
    decomposition.h_kiss.should == File.read('spec/fixtures/opus.h')
  end

  it 'should properly report whether it’s valid' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    qu  = Blanket[B[0,1,2,3,4,5,17], B[6,7,8,9,10,11,12,13,14,15,16,18,19]]
    qv  = Blanket[B[0,1,2,17,19], B[3,6,7,8,9,10,11,12], B[4,5,18], B[13,14,15,16]]
    g   = Blanket[B[0,1,4,6,17,18,19], B[2,7,9,11], B[3,5,8,10,12], B[13,14,15,16]]
    Decomposition.new(fsm, [1,3], [0,2], qu, qv, g).should     be_valid
    Decomposition.new(fsm, [1,3], [0,2], qv, qu, g).should_not be_valid
    Decomposition.new(fsm, [1,3], [0,2], qv, qv, g).should_not be_valid
  end

  it 'should optionally hold the information on what generators were used to construct it' do
    fsm = mock FSM
    qu, qv, g = mock(Blanket), mock(Blanket), mock(Blanket)
    d = Decomposition.new fsm, [0], [1], qu, qv, g, :uv_gen => UVGenerator::Braindead, :qu_gen => QuGenerator::BlockTable, :qv_gen => QvGenerator::GraphColouring
    d.uv_gen.should == UVGenerator::Braindead
    d.qu_gen.should == QuGenerator::BlockTable
    d.qv_gen.should == QvGenerator::GraphColouring
  end

  it 'should properly report whether it’s decomposable further' do
    fsm = mock FSM
    qv  = mock Blanket
    g   = mock Blanket
    qu1 = mock Blanket, :size => 2
    qu2 = mock Blanket, :size => 3
    Decomposition.new(fsm, [0], [1], qu1, qv, g).should_not be_decomposable
    Decomposition.new(fsm, [0], [1], qu2, qv, g).should     be_decomposable
  end

  it 'should properly report whether it’s sensible, based on G block’s architecture and wether Qu or Qv are smaller than Q' do
    fsm = mock FSM, :beta_q => mock(Blanket, :size => 5)
    qu  = mock Blanket, :pins => 3, :size => 5
    qv  = mock Blanket, :pins => 2, :size => 4
    g   = mock Blanket, :pins => 3
    Decomposition.new(fsm, [0,2], [1], qu, qv, g).should_not be_sensible
    Decomposition.new(fsm, [0], [1,2], qu, qv, g).should     be_sensible
    Decomposition.new(fsm, [0], [1,2], qu, qu, g).should_not be_sensible
  end

end end
