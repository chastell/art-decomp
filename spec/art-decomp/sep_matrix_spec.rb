require_relative '../spec_helper'

module ArtDecomp describe SepMatrix do
  describe '#==' do
    it 'compares SepMatrices properly' do
      SepMatrix.new([]).must_equal SepMatrix.new []
    end
  end

  describe '#seps' do
    it 'returns provided Seps' do
      SepMatrix.new([
        0b1000,
        0b0100,
        0b0010,
        0b0001,
      ]).seps.must_equal Set[Sep[0,3], Sep[1,2]]
    end
  end
end end
