# encoding: UTF-8

module ArtDecomp describe UVGenerator::UniqueRelevance do

  describe '#uv_pairs' do

    it 'calls UVRelevanceGenerator’s uv_pairs method with proper args' do
      fsm = mock FSM
      fsm.should_receive(:unique_relevance).and_return []
      UVGenerator::UniqueRelevance.new.uv_pairs fsm, Set[Arch[5,1]]
    end

  end

end end
