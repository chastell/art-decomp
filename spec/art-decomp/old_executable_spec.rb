# encoding: UTF-8

require_relative '../spec_helper'

module ArtDecomp describe OldExecutable do
  before do
    @dir  = "#{Dir.tmpdir}/#{rand.to_s}"
    @fsm  = 'spec/fixtures/fsm'
    @args = ['--archs', '5/1', '--outdir', @dir, @fsm]
  end

  after do
    FileUtils.rmtree @dir
  end

  describe '.new' do
    it 'requires an FSM' do
      capture_io { -> { OldExecutable.new [] }.must_raise SystemExit }.last.must_include 'no FSM given'
    end

    it 'requires that the FSM exists' do
      capture_io { -> { OldExecutable.new ['bogus'] }.must_raise SystemExit }.last.must_include 'FSM does not exist'
    end

    it 'requires at least one target Arch' do
      capture_io { -> { OldExecutable.new [@fsm] }.must_raise SystemExit }.last.must_include 'no architecture given'
    end

    it 'requires that all architectures are parsable' do
      args = ['--archs', '5/1', 'a/b', '--outdir', @dir, @fsm]
      capture_io { -> { OldExecutable.new args }.must_raise SystemExit }.last.must_include 'archs not in the form of inputs/outputs'
    end

    it 'requires output directory' do
      capture_io { -> { OldExecutable.new ['--archs', '5/1', '--', @fsm] }.must_raise SystemExit }.last.must_include 'no output directory given'
    end

    it 'requires that the output directory does not exist' do
      capture_io { -> { OldExecutable.new ['--archs', '5/1', '--outdir', Dir.tmpdir, @fsm] }.must_raise SystemExit }.last.must_include 'output directory exists'
    end

    it 'requires that the output directory is creatable' do
      Dir.mkdir @dir, 0400
      subdir = "#{@dir}/#{rand.to_s}"
      capture_io { -> { OldExecutable.new ['--archs', '5/1', '--outdir', subdir, @fsm] }.must_raise SystemExit }.last.must_include 'output directory cannot be created'
    end

    it 'creates the output directory' do
      refute Pathname(@dir).exist?
      OldExecutable.new @args
      assert Pathname(@dir).exist?
    end

    it 'validates that the specified UV generator exists' do
      capture_io { -> { OldExecutable.new @args + ['--uv', 'bogus'] }.must_raise SystemExit }.last.must_include 'no such UV generator'
    end

    it 'validates that the specified Qu generator exists' do
      capture_io { -> { OldExecutable.new @args + ['--qu', 'bogus'] }.must_raise SystemExit }.last.must_include 'no such Qu generator'
    end

    it 'validates that the specified Qv generator exists' do
      capture_io { -> { OldExecutable.new @args + ['--qv', 'bogus'] }.must_raise SystemExit }.last.must_include 'no such Qv generator'
    end

    it 'allows logging to the specified file/stream' do
      log = Tempfile.new rand.to_s
      fake_decomposer = Class.new do
        def initialize *_; end
        def decompositions *_; [].each; end
      end
      OldExecutable.new(['--archs', '5/1', '4/2', '--debug', '--log', log.path, '--outdir', @dir, @fsm]).run true, fake_decomposer
      Logging.level.must_equal Logger::DEBUG
      Logging.off
      File.read(log.path).must_include '4/2+10s'
    end
  end

  describe '#run' do
    it 'dumps the resulting decompositions into a file' do
      $dec = Decomposition.new FSM.from_kiss(@fsm), Set[0], Set[1], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[]
      fake_decomposer = Class.new do
        def initialize *_; end
        def decompositions *_; [$dec, $dec].each; end
      end
      OldExecutable.new(@args).run false, fake_decomposer
      Marshal.load(File.read("#{@dir}/decompositions")).must_equal [$dec, $dec]
    end

    it 'creates files holding the resulting Decomposition objects and keeps track of the best decomposition' do
      $dec0 = Decomposition.new FSM.from_kiss(@fsm), Set[0], Set[1], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[]
      $dec1 = Decomposition.new FSM.from_kiss(@fsm), Set[1], Set[0], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[]
      fake_decomposer = Class.new do
        def initialize *_; end
        def decompositions *_; [$dec0, $dec1].each; end
      end
      ex = OldExecutable.new @args
      ex.best.must_be_nil
      ex.run true, fake_decomposer
      ex.best.must_equal 4
      Marshal.load(File.read("#{@dir}/0.dec")).must_equal $dec0
      Marshal.load(File.read("#{@dir}/1.dec")).must_equal $dec1
    end

  #   it 'passes all of the requested generators and architectures to the OldDecomposer' do
  #     fsm = mock FSM, fsm_cells: nil, implementable_in?: false, stats: ''
  #     FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

  #     decomposer = mock OldDecomposer, decompositions: [].each
  #     OldDecomposer.should_receive(:new).with(fsm: fsm, archs: Set[Arch[4,2], Arch[5,1]], uv_gens: [UVGenerator::Braindead, UVGenerator::Braindead], qu_gens: [QuGenerator::BlockTable, QuGenerator::EdgeLabels], qv_gens: [QvGenerator::GraphMerging, QvGenerator::Bipainting]).and_return decomposer

  #     args = ['--archs', '5/1', '4/2', '--uv', 'Braindead', 'Braindead', '--qu', 'BlockTable', 'EdgeLabels', '--qv', 'GraphMerging', 'Bipainting', '--outdir', @dir, @fsm]
  #     OldExecutable.new(args).run
  #   end

  #   it 'allows setting any of the generators to ‘all’' do
  #     fsm = mock FSM, fsm_cells: nil, implementable_in?: false, stats: ''
  #     FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

  #     decomposer = mock OldDecomposer, decompositions: [].each
  #     OldDecomposer.should_receive(:new).with(fsm: fsm, archs: Set[Arch[5,1]], uv_gens: [UVGenerator::Braindead, UVGenerator::GeneralRelevance, UVGenerator::UniqueRelevance], qu_gens: [QuGenerator::BlockTable, QuGenerator::EdgeLabels], qv_gens: [QvGenerator::Bipainting, QvGenerator::GraphColouring,QvGenerator::GraphMerging]).and_return decomposer

  #     args = ['--archs', '5/1', '--uv', 'all', '--qu', 'all', '--qv', 'all', '--outdir', @dir, @fsm]
  #     OldExecutable.new(args).run
  #   end

    it 'decomposes iteratively according to the number of iterations' do
      args = ['--archs', '2/1', '--iters', '2', '--outdir', @dir, 'spec/fixtures/lion']
      fake_decomposer = Class.new do
        def initialize *_; end
        def decompositions *_
          [Decomposition.new(FSM.from_kiss('spec/fixtures/lion'), Set[0], Set[1], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[])].each
        end
      end
      OldExecutable.new(args).run true, fake_decomposer
      assert Pathname("#{@dir}/0.dec").exist?
      assert Pathname("#{@dir}/0/0.dec").exist?
      refute Pathname("#{@dir}/0/0/0.dec").exist?
    end

    it 'handles the s8 edge case with grace' do
      log = Tempfile.new rand.to_s
      OldExecutable.new(['--archs', '2/1', '--log', log.path, '--outdir', @dir, 'spec/fixtures/s8']).run
      Logging.off
      File.read(log.path).must_include ' 0c'
    end
  end

  describe '#gens' do
    it 'reports on what it’s using when asked' do
      args = ['--archs', '2/1', '--uv', 'Braindead', 'Braindead', '--qu', 'BlockTable', 'EdgeLabels', '--qv', 'GraphMerging', 'Bipainting', '--outdir', @dir, @fsm]
      OldExecutable.new(args).gens.must_equal 'Braindead+Braindead, BlockTable+EdgeLabels, GraphMerging+Bipainting'
    end
  end

  describe '#archs' do
    it 'exposes the target architecture(s)' do
      args = ['--archs', '5/1', '4/2', '--outdir', @dir, 'spec/fixtures/lion']
      OldExecutable.new(args).archs.must_equal Set[Arch[5,1], Arch[4,2]]
    end
  end

  describe '#iters' do
    it 'exposes the number of iterations' do
      args = ['--archs', '2/1', '--iters', '2', '--outdir', @dir, 'spec/fixtures/lion']
      OldExecutable.new(args).iters.must_equal 2
    end
  end

  describe '#dir' do
    it 'exposes the target dir' do
      args = ['--archs', '2/1', '--outdir', @dir, 'spec/fixtures/lion']
      OldExecutable.new(args).dir.must_equal @dir
    end
  end

  # FIXME: add specs for --binary, --non-disjoint and --deep-ndj
end end
