# encoding: UTF-8

require_relative '../../lib/art-decomp/logging'

module ArtDecomp describe Logging do

  context 'when logging is enabled' do

    before do
      @dir = "#{Dir.tmpdir}/#{rand.to_s}"
      @fsm = mock FSM, beta_f: Blanket[], beta_q: Blanket[], beta_x: Blanket[]
      @log = StringIO.new
      Logging.log = @log
      Logging.level = Logger::INFO
    end

    after do
      Logging.off
      FileUtils.rmtree @dir if Dir.exists? @dir
    end

    def log
      @log.rewind
      @log.read
    end

    it 'logs Executable’s decompositions calls on simple cases' do
      args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/lion']
      Executable.new(args).run
      log.should =~ /took 1s/
    end

    it 'logs Executable’s decompositions calls on typical cases' do
      Decomposer.should_receive(:new).and_return mock(Decomposer, decompositions: [].each)
      args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/fsm']
      ex = Executable.new(args)
      ex.stub!(:best).and_return 69
      ex.run
      log.should =~ Regexp.new(Regexp.escape '4/2+10s with UniqueRelevance, EdgeLabels, GraphColouring')
      log.should =~ /took 1s/
    end

    it 'logs Executable’s decompositions calls on problematic cases' do
      Decomposer.should_receive(:new).and_return mock(Decomposer, decompositions: [].each)
      args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/fsm']
      Executable.new(args).run
      log.should =~ Regexp.new(Regexp.escape '4/2+10s with UniqueRelevance, EdgeLabels, GraphColouring')
      log.should =~ /took 1s/
    end

    it 'logs QuGenerators’ blankets calls (if debug-level logging enabled)' do
      Logging.level = Logger::DEBUG
      qu = QuGenerator::BlockTable.new
      [[Set[0], Set[1]], [Set[1], Set[0]]].each do |u, v|
        qu.blankets @fsm, u, v
      end
      log.should =~ /0          1          via  with BlockTable/
      log.should =~ /1          0          via  with BlockTable/
    end

  end

end end
