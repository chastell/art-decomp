module ArtDecomp module UVGenerator class GeneralRelevance < UVRelevanceGenerator
  def uv_pairs fsm, archs
    super fsm, archs, :general_relevance
  end
end end end
