module ArtDecomp
  module UVGenerators
    class UniqueRelevance < UVRelevanceGenerator
      def uv_pairs fsm, archs
        super fsm, archs, :unique_relevance
      end
    end
  end
end
