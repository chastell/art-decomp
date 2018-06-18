require_relative '../spec_helper'

module ArtDecomp
  describe VHDL do
  def verify_vhdl fsm_name
    vhdl_name = fsm_name.tr '.', '_'
    fsm = VHDL.new(FSM.from_kiss("spec/fixtures/#{fsm_name}")).vhdl vhdl_name
    fsm.must_equal File.read "spec/fixtures/#{vhdl_name}.vhd"
  end

  describe '#vhdl' do
    it 'generates the VHDL representation of the underlying FSM' do
      verify_vhdl 'fsm'
      verify_vhdl 'mark1'
    end

    it 'generates encoded VHDL if the FSM is encoded' do
      verify_vhdl 'mark1.hot'
    end

    it 'renames digit-only states' do
      verify_vhdl 'ex4.hot'
    end
  end
  end end
