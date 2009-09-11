require_relative '../../lib/art-decomp/logging'

module ArtDecomp describe Logging do

  before do
    @log = StringIO.new
    Logging.log = @log
  end

  after do
    Logging.log = '/dev/null'
  end

  def log
    @log.rewind
    @log.read
  end

  it 'should log Decomposer initialisations' do
    Decomposer.new :archs => Set[Arch[5,1], Arch[4,2]], :uv_gens => [], :qu_gens => [], :qv_gens => []
    log.should =~ /^20..-..-.. ..:..:.. ....0 decomposing into 5\/1\+4\/2 archs$/
  end

end end
