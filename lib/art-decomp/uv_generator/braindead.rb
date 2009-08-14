module ArtDecomp class UVGenerator::Braindead

  def initialize fsm, archs
    @input_count = fsm.input_count
    @max_v_size  = archs.map { |a| a.pins }.max
  end

  def each
    inputs = (0...@input_count).to_a
    (0...2**@input_count).each do |vector|
      u, v = [], []
      @input_count.times do |bit|
        (vector[bit].zero? ? u : v) << inputs[bit]
      end
      yield u, v if v.size <= @max_v_size
    end
  end

end end
