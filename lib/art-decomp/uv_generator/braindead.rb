module ArtDecomp class UVGenerator::Braindead

  def initialize fsm, archs
    @fsm         = fsm
    @input_count = fsm.input_count
    @max_v_size  = archs.map(&:pins).max
  end

  def uv_pairs
    Enumerator.new do |yielder|
      inputs = (0...@input_count).to_a
      (0...2**@input_count).each do |vector|
        u, v = [], []
        @input_count.times do |bit|
          (vector[bit].zero? ? u : v) << inputs[bit]
        end
        yielder.yield @fsm.expand_x(v), u, v if v.size <= @max_v_size
      end
    end
  end

end end
