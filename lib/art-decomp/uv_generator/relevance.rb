module ArtDecomp class UVGenerator::Relevance

  def initialize fsm, archs
    @fsm        = fsm
    @relevance  = fsm.input_relevance.reverse
    @max_v_size = archs.map(&:pins).max
  end

  def uv_pairs
    @cache = Set[]
    Enumerator.new do |yielder|
      (0...2**@relevance.size).each do |vector|
        bits = vector.bits
        next unless bits.size == @max_v_size
        v = @relevance.values_at(*bits).compact.sort
        u = (@relevance - v).compact.sort
        yielder.yield @fsm.expand_x(v), u, v unless @cache.include? v
        @cache << v
      end
    end
  end

end end
