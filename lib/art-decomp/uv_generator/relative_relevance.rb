module ArtDecomp module UVGenerator class RelativeRelevance < UVRelevanceGenerator
  def uv_pairs fsm, archs
    super fsm, archs, :relative_relevance
  end
end end end
