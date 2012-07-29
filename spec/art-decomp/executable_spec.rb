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

    it 'does not raise with minimal arguments' do
      Executable.new min_args
    end

    it 'starts logging if so instructed' do
      logging_class = MiniTest::Mock.new.expect :new, nil, ['unknown']
      Executable.new ['--log', 'unknown'] + min_args, logging_class: logging_class
      logging_class.verify
    end
  end

  describe '#run' do
    let(:executable) { Executable.new min_args }

    it 'configures the DecTreeGenerator' do
      dt_gen_class = MiniTest::Mock.new.expect :new, OpenStruct.new(dectrees: []), [{
        archs: Set[Arch[5,1]],
        fsm:   FSM.from_kiss(fsm_path),
        gens:  { uv: [UVGenerators::RelativeRelevance.new], qu: [QuGenerators::EdgeLabels.new], qv: [QvGenerators::GraphColouring.new] },
      }]
      executable.run dec_tree_generator_class: dt_gen_class
      dt_gen_class.verify
    end

    it 'saves the DecTrees to the results dir' do
      dt_gen_class = Class.new do
        def initialize *_
        end
        def dectrees
          [
            MiniTest::Mock.new.expect(:to_vhdl, 'VHDL A', [Set[Arch[5,1]], 'fsm_0']),
            MiniTest::Mock.new.expect(:to_vhdl, 'VHDL B', [Set[Arch[5,1]], 'fsm_1']),
          ]
        end
      end
      executable.run dec_tree_generator_class: dt_gen_class, dir_prefix: 'dir_prefix'
      File.read("#{dir_path}/fsm/5:1/dir_prefix/fsm_0.vhdl").must_equal 'VHDL A'
      File.read("#{dir_path}/fsm/5:1/dir_prefix/fsm_1.vhdl").must_equal 'VHDL B'
    end
  end
end end
