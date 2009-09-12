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
    Decomposer.new :archs => Set[Arch[5,1], Arch[4,2]], :uv_gens => [], :qu_gens => [], :qv_gens => []
    log.should =~ /^20..-..-.. ..:..:.. ....0 decomposing into 5\/1\+4\/2 archs$/
  end

  it 'should log QuGenerators’ blankets calls' do
    qu = QuGenerator::BlockTable.new
    [[[0], [1]], [[1], [0]]].each do |u, v|
      qu.blankets mock(FSM), u, v
    end
    log.should =~ /U = \[0\], V = \[1\]/
    log.should =~ /U = \[1\], V = \[0\]/
  end

end end
