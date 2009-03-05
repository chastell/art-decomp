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

end
