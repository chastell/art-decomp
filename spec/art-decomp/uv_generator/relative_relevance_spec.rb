# encoding: UTF-8

require_relative '../../spec_helper'

module ArtDecomp describe UVGenerator::RelativeRelevance do
  describe '#uv_pairs' do
    it 'calls UVRelevanceGenerator’s uv_pairs method with proper args' do
      fsm = MiniTest::Mock.new.expect :send, [], [:relative_relevance]
      UVGenerator::RelativeRelevance.new.uv_pairs fsm, Set[Arch[5,1]]
      fsm.verify
    end
  end
end end
