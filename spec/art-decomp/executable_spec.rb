require_relative '../spec_helper'
require_relative '../../lib/art-decomp/executable'

module ArtDecomp describe Executable do
  let(:fsm_path) { 'spec/fixtures/fsm' }

  describe '.new' do
    it 'gives help when asked' do
      -> { -> { Executable.new ['--help'] }.must_raise SystemExit }.must_output <<-end.gsub(/^ {8}/, '')
        Options:
          --help, -h:   Show this message
      end
    end

    it 'requires a path to an existing FSM' do
      capture_io { -> { Executable.new []        }.must_raise SystemExit }.last.must_include 'no FSM given'
      capture_io { -> { Executable.new ['bogus'] }.must_raise SystemExit }.last.must_include 'FSM does not exist'
    end

    it 'requires one or more architectures' do
      capture_io { -> { Executable.new [fsm_path] }.must_raise SystemExit }.last.must_include 'no architecture(s) given'
    end
  end
end end
