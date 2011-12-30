module ArtDecomp class UVGenerator::GeneralRelevance < UVRelevanceGenerator
  def uv_pairs fsm, archs
    super fsm, archs, :general_relevance
  end
end end
