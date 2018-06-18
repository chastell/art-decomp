require_relative '../../spec_helper'

module ArtDecomp
  describe QvGenerators::GraphMerging do
  describe '#==' do
    it 'performs class-based comparison' do
      QvGenerators::GraphMerging.new.must_equal QvGenerators::GraphMerging.new
    end
  end

  describe '#blankets' do
    it 'merges vertices of the proper incompatibility graphs' do
      verify_qv_blankets QvGenerators::GraphMerging.new, [
        [Blanket[B[1,2], B[3,4], B[5,6]], Blanket[B[1,5], B[2,3], B[4,6]]],
        [Blanket[B[1,2], B[3,4,5,6]], Blanket[B[1], B[2,3,5], B[4,6]]],
      ]
    end
  end
  end end
