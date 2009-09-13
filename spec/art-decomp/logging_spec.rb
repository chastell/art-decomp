# encoding: UTF-8

require_relative '../../lib/art-decomp/logging'

module ArtDecomp describe Logging do

  before do
    @log = StringIO.new
    Logging.log = @log
  end

  after do
    Logging.off
  end

  def log
    @log.rewind
    @log.read
  end

  it 'should log Executable’s decompositions calls' do
    Decomposer.should_receive(:new).and_return mock(Decomposer, :decompositions => [].each)
    args = ['-a', '5/1', '4/2', '-o', "#{Dir.tmpdir}/#{rand.to_s}", 'spec/fixtures/lion']
    Executable.new(args).run
    log.should =~ rex('FSM 2/1/4s → 5/1+4/2 () with Braindead, BlockTable, GraphColouring')
  end

  it 'should log UVGenerators’ uv_pairs calls' do
    uv = UVGenerator::Braindead.new mock(FSM, :input_count => 2), Set[Arch[5,1]]
    uv.uv_pairs
    log.should =~ rex('UV with Braindead')
  end

  it 'should log QuGenerators’ blankets calls' do
    qu = QuGenerator::BlockTable.new
    [[[0], [1]], [[1], [0]]].each do |u, v|
      qu.blankets mock(FSM), u, v
    end
    log.should =~ rex('U = [0], V = [1], Qu with BlockTable')
    log.should =~ rex('U = [1], V = [0], Qu with BlockTable')
  end

  it 'should log QvGenerators’ blankets calls (on the DEBUG level)' do
    Logging.level = Logger::DEBUG
    qv = QvGenerator::GraphColouring.new
    [mock(Blanket, :size => 8), mock(Blanket, :size => 4)].each do |qu|
      qv.blankets mock(FSM), [0], [1], qu
    end
    log.should =~ rex('|Qu| = 8, Qv+G with GraphColouring')
    log.should =~ rex('|Qu| = 4, Qv+G with GraphColouring')
  end

end end
