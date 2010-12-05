# encoding: UTF-8

module ArtDecomp describe UVGenerator::GeneralRelevance do

  context '#uv_pairs' do

    it 'calls UVRelevanceGenerator’s uv_pairs method with proper args' do
      fsm = mock FSM
      fsm.should_receive(:general_relevance).and_return []
      UVGenerator::GeneralRelevance.new.uv_pairs fsm, Set[Arch[5,1]]
    end

  end

end end
