require_relative '../spec_helper'
require_relative '../../lib/art-decomp/executable'

module ArtDecomp describe Executable do
  describe '.new' do
    it 'requires a path to an existing FSM' do
      capture_io { -> { Executable.new [] }.must_raise SystemExit }.last.must_include 'no FSM given'
    end
  end
end end
