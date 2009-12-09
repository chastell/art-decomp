module ArtDecomp class UVGenerator::GeneralRelevance

  def initialize fsm, archs
    @fsm         = fsm
    @relevance   = fsm.general_relevance.reverse
    @max_v_sizes = archs.map(&:pins).to_set
  end

  def uv_pairs
    @cache = Set[]
    Enumerator.new do |yielder|
      (0...2**@relevance.size).each do |vector|
        bits = vector.bits
        next unless @max_v_sizes.include? bits.size
        v = @relevance.values_at(*bits).compact.to_set
        u = (@relevance - v.to_a).compact.to_set
        yielder.yield @fsm.expand_x(v), u, v unless @cache.include? v
        @cache << v
      end
    end
  end

end end
