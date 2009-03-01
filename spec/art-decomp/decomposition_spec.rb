describe Decomposition do

  it 'should instantiate and compare properly' do
    fsm = mock 'FSM'
    u, v = [0,1], [2]
    qu, qv, g = mock('Blanket'), mock('Blanket'), mock('Blanket')
    dec = Decomposition.new fsm, u, v, qu, qv, g
    [dec.fsm, dec.u, dec.v, dec.qu, dec.qv, dec.g].should == [fsm, u, v, qu, qv, g]
  end

end
