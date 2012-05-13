# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/art-decomp/logging'

module ArtDecomp describe Logging do
  class FakeDecomposer
    def initialize *; end
    def decompositions *; [].each; end
  end

  before do
    @dir = "#{Dir.tmpdir}/#{rand.to_s}"
    @log = StringIO.new
    Logging.log = @log
    Logging.level = Logger::INFO
  end

  after do
    Logging.off
    FileUtils.rmtree @dir
  end

  def log
    @log.rewind
    @log.read
  end

  it 'logs OldExecutable’s decompositions calls on simple cases' do
    args = ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/lion']
    OldExecutable.new(args).run
    log.must_include 'took 1s'
  end

  it 'logs OldExecutable’s decompositions calls on typical cases' do
    ex = OldExecutable.new ['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/fsm']
    def ex.best; 69; end
    ex.run true, FakeDecomposer
    log.must_include '4/2+10s with UniqueRelevance, EdgeLabels, GraphColouring'
    log.must_include 'took 1s'
  end

  it 'logs OldExecutable’s decompositions calls on problematic cases' do
    OldExecutable.new(['-a', '5/1', '4/2', '-o', @dir, 'spec/fixtures/fsm']).run true, FakeDecomposer
    log.must_include '4/2+10s with UniqueRelevance, EdgeLabels, GraphColouring'
    log.must_include 'took 1s'
  end

  it 'logs QuGenerators’ blankets calls (if debug-level logging enabled)' do
    fsm = MiniTest::Mock.new
    2.times { fsm.expect :beta_f, Blanket[] }
    2.times { fsm.expect :beta_q, Blanket[] }
    2.times { fsm.expect :beta_x, Blanket[], [Set] }
    Logging.level = Logger::DEBUG
    qu = QuGenerators::BlockTable.new
    [[Set[0], Set[1]], [Set[1], Set[0]]].each do |u, v|
      qu.blankets fsm, u, v
    end
    log.must_include '0          1'
    log.must_include '1          0'
  end
end end
