module ArtDecomp
  class UVRelevanceGenerator
    def ==(other)
      self.class == other.class
    end

    def uv_pairs(fsm, archs, method) # rubocop:disable MethodLength
      relevance   = fsm.send(method).reverse
      max_v_sizes = archs.map(&:pins).to_set
      cache       = Set[]
      Enumerator.new do |yielder|
        (0...2**relevance.size).each do |vector|
          bits = vector.bits
          next unless max_v_sizes.include? bits.size
          v = relevance.values_at(*bits).compact.to_set
          u = (relevance - v.to_a).compact.to_set
          yielder.yield fsm.expand_x(v), u, v unless cache.include? v
          cache << v
        end
      end
    end
  end
end
