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

  it 'should log Decomposer initialisations' do
    Decomposer.new :archs => Set[Arch[5,1], Arch[4,2]], :uv_gens => [], :qu_gens => [], :qv_gens => [], :fsm => mock(FSM, :stats => '4/2/10s')
    log.should =~ /^20..-..-.. ..:..:.. ....0 FSM 4\/2\/10s → 5\/1\+4\/2 cells$/
  end

  it 'should log UVGenerators’ uv_pairs calls' do
    uv = UVGenerator::Braindead.new mock(FSM, :input_count => 2), Set[Arch[5,1]]
    uv.uv_pairs
    log.should =~ /UV with Braindead/
  end

  it 'should log QuGenerators’ blankets calls' do
    qu = QuGenerator::BlockTable.new
    [[[0], [1]], [[1], [0]]].each do |u, v|
      qu.blankets mock(FSM), u, v
    end
    log.should =~ /U = \[0\], V = \[1\], Qu with BlockTable/
    log.should =~ /U = \[1\], V = \[0\], Qu with BlockTable/
  end

  it 'should log QvGenerators’ blankets calls (on the DEBUG level)' do
    Logging.level = Logger::DEBUG
    qv = QvGenerator::GraphColouring.new
    [mock(Blanket, :size => 8), mock(Blanket, :size => 4)].each do |qu|
      qv.blankets mock(FSM), [0], [1], qu
    end
    log.should =~ /\|Qu\| = 8, Qv\+G with GraphColouring/
    log.should =~ /\|Qu\| = 4, Qv\+G with GraphColouring/
  end

end end
