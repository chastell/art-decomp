require_relative '../spec_helper'
require_relative '../../lib/art-decomp/executable'

module ArtDecomp describe Executable do
  let(:dir_path) { Dir.mktmpdir }
  let(:fsm_path) { 'spec/fixtures/fsm' }
  let(:min_args) { ['--archs', '5/1', '--dir', dir_path, '--', fsm_path] }

  after { FileUtils.rmtree dir_path }

  describe '.new' do
    it 'gives help when asked' do
      -> { -> { Executable.new ['--help'] }.must_raise SystemExit }.must_output <<-end.gsub(/^ {8}/, '')
        Options:
          --archs, -a <s+>:   Target architecture(s)
             --dir, -d <s>:   Results directory
             --uv, -u <s+>:   UV generator(s) (default: RelativeRelevance)
             --qu, -q <s+>:   Qu generator(s) (default: EdgeLabels)
             --qv, -v <s+>:   Qv generator(s) (default: GraphColouring)
             --log, -l <s>:   Logging level
             --uv, -u <s+>:   UV generator(s) (default: RelativeRelevance)
             --qu, -q <s+>:   Qu generator(s) (default: EdgeLabels)
             --qv, -v <s+>:   Qv generator(s) (default: GraphColouring)
                --help, -h:   Show this message
      end
    end

    it 'requires a path to an existing FSM' do
      capture_io { -> { Executable.new min_args[0...-1]             }.must_raise SystemExit }.last.must_include 'no FSM given'
      capture_io { -> { Executable.new min_args[0...-1] + ['bogus'] }.must_raise SystemExit }.last.must_include 'FSM does not exist'
    end

    it 'requires one or more architectures' do
      capture_io { -> { Executable.new [fsm_path] }.must_raise SystemExit }.last.must_include '--archs must be specified'
    end

    it 'requires directory for results' do
      capture_io { -> { Executable.new ['--archs', '5/1', '--', fsm_path] }.must_raise SystemExit }.last.must_include '--dir must be specified'
    end

    it 'requires that architectures are parsable' do
      capture_io { -> { Executable.new min_args.insert 1, 'a/b' }.must_raise SystemExit }.last.must_include '--archs not in the form of inputs/outputs'
    end

    it 'requires that generators exist' do
      capture_io { -> { Executable.new ['--uv', 'foo'] + min_args }.must_raise SystemExit }.last.must_include '--uv generator does not exist'
      capture_io { -> { Executable.new ['--qu', 'foo'] + min_args }.must_raise SystemExit }.last.must_include '--qu generator does not exist'
      capture_io { -> { Executable.new ['--qv', 'foo'] + min_args }.must_raise SystemExit }.last.must_include '--qv generator does not exist'
    end

    it 'requires that generators exist' do
      capture_io { -> { Executable.new ['--uv', 'foo'] + min_args }.must_raise SystemExit }.last.must_include '--uv generator does not exist'
      capture_io { -> { Executable.new ['--qu', 'foo'] + min_args }.must_raise SystemExit }.last.must_include '--qu generator does not exist'
      capture_io { -> { Executable.new ['--qv', 'foo'] + min_args }.must_raise SystemExit }.last.must_include '--qv generator does not exist'
    end

    it 'does not raise with minimal arguments' do
      Executable.new min_args
    end
  end
end end
