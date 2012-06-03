module ArtDecomp module UVGenerators class RelativeRelevance < UVRelevanceGenerator
  def uv_pairs fsm, archs
    # super fsm, archs, :relative_relevance
    Enumerator.new do |yielder|
      case fsm.input_count
      when 4 then u, v = Set[2], Set[0, 1, 3]
      when 3 then u, v = Set[0], Set[1, 2]
      end
      yielder.yield fsm.expand_x(v), u, v
    end
  end
end end end
