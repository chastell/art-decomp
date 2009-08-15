module ArtDecomp describe Decomposition do

  it 'should instantiate, compare and hash properly' do
    fsm = mock 'FSM'
    u, v = [0,1], [2]
    qu, qv, g = mock('Blanket'), mock('Blanket'), mock('Blanket')
    dec = Decomposition.new fsm, u, v, qu, qv, g
    dec.should      == Decomposition.new(fsm, u, v, qu, qv, g)
    dec.should_not  == Decomposition.new(fsm, v, u, qu, qv, g)
    dec.should_not  == Decomposition.new(fsm, u, v, qv, qu, g)
    dec.hash.should == Decomposition.new(fsm, u, v, qu, qv, g).hash
  end

  it 'should create its G and H blocks’ KISS representations properly' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    qu  = Blanket[B[0,1,2,3,4,5,17], B[6,7,8,9,10,11,12,13,14,15,16,18,19]]
    qv  = Blanket[B[0,1,2,17,19], B[3,6,7,8,9,10,11,12], B[4,5,18], B[13,14,15,16]]
    g   = Blanket[B[0,1,4,6,17,18,19], B[2,7,9,11], B[3,5,8,10,12], B[13,14,15,16]]
    decomposition = Decomposition.new fsm, [1,3], [0,2], qu, qv, g
    decomposition.g_kiss.should == File.read('spec/fixtures/fsm.g')
    decomposition.h_kiss.should == File.read('spec/fixtures/fsm.h')
  end

  it 'should create the H block properly, even if the G blanket seems ambiguous' do
    fsm = FSM.from_kiss 'spec/fixtures/lion'
    qu  = Blanket[B[0,1,2,3,4,5], B[6,7,8,9,10]]
    qv  = Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]]
    g   = Blanket[B[0,1,7,8], B[0,2,9], B[3], B[4,5,6,10]]
    decomposition = Decomposition.new fsm, [1], [0], qu, qv, g
    decomposition.h_kiss.should == File.read('spec/fixtures/lion.h')
  end

  it 'should create the G and H blocks properly, even if the G blanket is ambiguous' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    qu  = Blanket[B[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]]
    qv  = Blanket[B[0,1,2], B[3,17], B[4,5], B[6,7,8,9,10,11,12], B[13,14], B[15,16,18], B[19]]
    g   = Blanket[B[0,1,2,5], B[3,8,9,10,11,17], B[4,5,13,15], B[6,7,12,19], B[14,16,18]]
    decomposition = Decomposition.new fsm, [0,2,3], [1], qu, qv, g
    decomposition.g_kiss.should == File.read('spec/fixtures/fsm.amb.g')
    decomposition.h_kiss.should == File.read('spec/fixtures/fsm.amb.h')
  end

  it 'should create the G and H blocks properly, even if the G blanket is (very) ambiguous' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    qu  = Blanket[B[0,4,5,13,14,15,16,18,19], B[1,2,3,6,7,8,9,10,11,12,17]]
    qv  = Blanket[B[0,4,5,6,7,8,9,10,11,12,18], B[1,2], B[3,13,14,15,16,17,19]]
    g   = Blanket[B[0,5,6], B[0,5,7], B[0,5,9,11], B[1,17], B[2,14,15], B[3], B[4,8,10,13], B[12,16,18,19]]
    decomposition = Decomposition.new fsm, [3], [0,1,2], qu, qv, g
    decomposition.g_kiss.should == File.read('spec/fixtures/fsm.3.012.g')
    decomposition.h_kiss.should == File.read('spec/fixtures/fsm.3.012.h')
  end

  it 'should properly recode don’t-care states to *' do
    fsm = FSM.from_kiss 'spec/fixtures/opus'
    qu  = Blanket[B[0,1,2,3,4,20,21], B[0,5,6,7], B[0,8,9,10,11,12,13,14,15,16], B[0,17,18,19]]
    qv  = Blanket[B[0,1,2,6,7,8,9,10,11,12,13,14,17,18], B[0,3,4,5,15,16,19], B[0,20,21]]
    g   = Blanket[B[0,1], B[2,6,7,8,10,12,14,17,18], B[2,6,7,9,11,13,14,17,18], B[3,4,5,15,16,19], B[20,21]]
    decomposition = Decomposition.new fsm, [1,3,4], [0,2], qu, qv, g
    decomposition.h_kiss.should == File.read('spec/fixtures/opus.h')
  end

end end
