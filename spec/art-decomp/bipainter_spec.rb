require_relative '../spec_helper'

module ArtDecomp describe Bipainter do
  describe '#blankets' do
    it 'returns the Qv and G Blankets based on the provided Q and V Blankets and a Set of Seps' do
      beta_q = Blanket[B[1,2], B[3,4], B[5,6]]
      beta_v = Blanket[B[1,3,5], B[2,4,6]]
      seps   = SepMatrix.from_seps [[1,2], [1,3], [1,6], [2,6], [3,4], [3,6], [4,5], [5,6]]

      bipainter = Bipainter.new beta_q, beta_v, seps
      bipainter.blankets.must_equal [Blanket[B[1,2], B[3,4,5,6]], Blanket[B[1], B[2,3,5], B[4,6]]]
    end

    it 'raises a RuntimeError on non-disjoint beta_v' do
      -> { Bipainter.new Blanket[], Blanket[B[0,1], B[0,2]], Set[] }.must_raise RuntimeError
    end

    # FIXME: way underspec’d
  end
end end
