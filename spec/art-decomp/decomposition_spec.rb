describe Decomposition do

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

  it 'should create its G block’s KISS representation properly' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    qu  = Blanket[B[0,1,2,3,4,5,17], B[6,7,8,9,10,11,12,13,14,15,16,18,19]]
    qv  = Blanket[B[0,1,2,17,19], B[3,6,7,8,9,10,11,12], B[4,5,18], B[13,14,15,16]]
    g   = Blanket[B[0,1,4,6,17,18,19], B[2,7,9,11], B[3,5,8,10,12], B[13,14,15,16]]
    decomposition = Decomposition.new fsm, [1,3], [0,2], qu, qv, g
    decomposition.g_kiss.should == File.read('spec/fixtures/fsm.g')
  end

  it 'should create its H block’s KISS representation properly' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    qu  = Blanket[B[0,1,2,3,4,5,17], B[6,7,8,9,10,11,12,13,14,15,16,18,19]]
    qv  = Blanket[B[0,1,2,17,19], B[3,6,7,8,9,10,11,12], B[4,5,18], B[13,14,15,16]]
    g   = Blanket[B[0,1,4,6,17,18,19], B[2,7,9,11], B[3,5,8,10,12], B[13,14,15,16]]
    decomposition = Decomposition.new fsm, [1,3], [0,2], qu, qv, g
    decomposition.h_kiss.should == File.read('spec/fixtures/fsm.h')
  end

end
