# encoding: UTF-8

module ArtDecomp describe VHDL do

  context 'generated from an FSM’s structure' do

    it 'should properly generates the VHDL representation' do
      VHDL.new(FSM.from_kiss('spec/fixtures/fsm').structure).vhdl('fsm').should     == File.read('spec/fixtures/fsm.vhd')
      VHDL.new(FSM.from_kiss('spec/fixtures/mark1').structure).vhdl('mark1').should == File.read('spec/fixtures/mark1.vhd')
    end

  end

end end
