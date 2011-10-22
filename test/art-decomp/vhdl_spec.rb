require_relative '../spec_helper'

module ArtDecomp describe VHDL do

  describe '#vhdl' do

    it 'generates the VHDL representation of the underlying FSM' do
      VHDL.new(FSM.from_kiss 'spec/fixtures/fsm').vhdl('fsm').must_equal     File.read('spec/fixtures/fsm.vhd')
      VHDL.new(FSM.from_kiss 'spec/fixtures/mark1').vhdl('mark1').must_equal File.read('spec/fixtures/mark1.vhd')
    end

    it 'generates encoded VHDL if the FSM is encoded' do
      VHDL.new(FSM.from_kiss 'spec/fixtures/mark1.hot').vhdl('mark1_hot').must_equal File.read('spec/fixtures/mark1_hot.vhd')
    end

    it 'renames digit-only states' do
      VHDL.new(FSM.from_kiss 'spec/fixtures/ex4.hot').vhdl('ex4_hot').must_equal File.read('spec/fixtures/ex4_hot.vhd')
    end

  end

end end
