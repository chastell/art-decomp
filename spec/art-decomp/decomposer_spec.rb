describe Decomposer do

  it 'should instantiate itself and the given InputSelector generator properly' do
    fsm    = mock 'FSM'
    arch1  = mock 'Arch', :pins => 5
    arch2  = mock 'Arch', :pins => 4
    uv_gen = mock 'InputSelector class'
    uv_gen.should_receive(:new).with fsm, 5
    decomposer = Decomposer.new :fsm => fsm, :archs => Set[arch1, arch2], :uv_gen => uv_gen
  end

end
