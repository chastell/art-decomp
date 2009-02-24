describe Decomposer do

  it 'should instantiate itself and the given InputSelector generator properly' do
    fsm    = mock 'FSM'
    archs  = Set[mock('Arch', :pins => 5), mock('Arch', :pins => 4)] # FIXME unmock
    uv_gen = mock 'InputSelector class'
    uv_gen.should_receive(:new).with fsm, 5
    decomposer = Decomposer.new :fsm => fsm, :archs => archs, :uv_gen => uv_gen
  end

end
