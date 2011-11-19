# encoding: UTF-8

require_relative '../../spec_helper'

module ArtDecomp describe UVGenerator::UniqueRelevance do

  describe '#uv_pairs' do

    it 'calls UVRelevanceGenerator’s uv_pairs method with proper args' do
      fsm = MiniTest::Mock.new
      fsm.expect :send, [], [:unique_relevance]
      UVGenerator::UniqueRelevance.new.uv_pairs fsm, Set[Arch[5,1]]
      fsm.verify
    end

  end

end end
