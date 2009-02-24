describe Decomposer do

  it 'should instantiate itself and its components properly' do
    fsm    = mock 'FSM'
    archs  = Set[mock('Arch', :pins => 5), mock('Arch', :pins => 4)] # FIXME unmock
    uv_gen = mock 'UVGenerator class'
    qu_gen = mock 'QuGenerator class'
    qv_gen = mock 'QvGenerator class'
    uv_gen.should_receive(:new).with fsm, archs
    qu_gen.should_receive(:new).with fsm, archs
    qv_gen.should_receive(:new).with fsm, archs
    decomposer = Decomposer.new :fsm => fsm, :archs => archs, :uv_gen => uv_gen, :qu_gen => qu_gen, :qv_gen => qv_gen
  end

end
