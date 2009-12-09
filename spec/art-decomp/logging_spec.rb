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
    log.should =~ rex('final best decomposition: 2')
  end

  it 'should log Executable’s decompositions calls on typical cases' do
    Decomposer.should_receive(:new).and_return mock(Decomposer, :decompositions => [].each)
    args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/fsm']
    Executable.new(args).run
    log.should =~ rex('FSM 4/2+10s → 5/1+4/2 () with GeneralRelevance, EdgeLabels, GraphColouring – best so far: ')
    log.should =~ rex('final best decomposition: ')
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

  it 'should log QvGenerators’ blankets calls (on the DEBUG level)' do
    Logging.level = Logger::DEBUG
    qv = QvGenerator::GraphColouring.new
    [mock(Blanket, :size => 8), mock(Blanket, :size => 4)].each do |qu|
      qv.blankets @fsm, Set[0], Set[1], qu
    end
    log.should =~ rex('|Qu| = 8, Qv+G with GraphColouring')
    log.should =~ rex('|Qu| = 4, Qv+G with GraphColouring')
  end

end end
