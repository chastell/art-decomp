# encoding: UTF-8

require_relative '../../lib/art-decomp/logging'

module ArtDecomp describe Logging do

  before do
    @dir = "#{Dir.tmpdir}/#{rand.to_s}"
    @fsm = mock FSM, :beta_f => Blanket[], :beta_q => Blanket[], :beta_x => Blanket[]
    @log = StringIO.new
    Logging.log = @log
  end

  after do
    Logging.off
    FileUtils.rmtree @dir if Dir.exists? @dir
  end

  def log
    @log.rewind
    @log.read
  end

  it 'should log Executable’s decompositions calls on simple cases' do
    args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/lion']
    Executable.new(args).run
    log.should =~ rex('best: 2c, took: 0h 0m 0s')
  end

  it 'should log Executable’s decompositions calls on typical cases' do
    Decomposer.should_receive(:new).and_return mock(Decomposer, :decompositions => [].each)
    args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/fsm']
    ex = Executable.new(args)
    ex.stub!(:best).and_return 69
    ex.run
    log.should =~ rex('FSM 4/2+10s → 5/1+4/2 () with UniqueRelevance, EdgeLabels, GraphColouring – best so far: 69 cells')
    log.should =~ rex('best: 69c, took: 0h 0m 0s')
  end

  it 'should log Executable’s decompositions calls on problematic cases' do
    Decomposer.should_receive(:new).and_return mock(Decomposer, :decompositions => [].each)
    args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/fsm']
    Executable.new(args).run
    log.should =~ rex('FSM 4/2+10s → 5/1+4/2 () with UniqueRelevance, EdgeLabels, GraphColouring – no decomposition so far')
    log.should =~ rex('best: c, took: 0h 0m 0s')
  end

  it 'should log UVGenerators’ uv_pairs calls' do
    uv = UVGenerator::Braindead.new
    uv.uv_pairs mock(FSM, :input_count => 2), Set[Arch[5,1]]
    log.should =~ rex('UV with Braindead')
  end

  it 'should log QuGenerators’ blankets calls' do
    qu = QuGenerator::BlockTable.new
    [[Set[0], Set[1]], [Set[1], Set[0]]].each do |u, v|
      qu.blankets @fsm, u, v
    end
    log.should =~ rex('U = [0], V = [1], Qu with BlockTable')
    log.should =~ rex('U = [1], V = [0], Qu with BlockTable')
  end

end end
