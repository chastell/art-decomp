module ArtDecomp::UVGenerator class Braindead

  def initialize fsm, archs
    @fsm, @archs = fsm, archs
  end

  def each
    inputs = (0...@fsm.input_count).to_a
    (0...2**@fsm.input_count).each do |vector|
      u, v = [], []
      @fsm.input_count.times do |bit|
        (vector[bit].zero? ? u : v) << inputs[bit]
      end
      yield u, v if v.size <= @archs.map{|a| a.pins}.max
    end
  end

end end
