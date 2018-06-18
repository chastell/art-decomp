require_relative '../../spec_helper'

module ArtDecomp
  describe QvGenerators::GraphColouring do
  describe '#==' do
    it 'performs class-based comparison' do
      QvGenerators::GraphColouring.new.must_equal QvGenerators::GraphColouring.new
    end
  end

  describe '#blankets' do
    it 'uses graph colouring of the proper incompatibility graphs' do
      verify_qv_blankets QvGenerators::GraphColouring.new, [
        [Blanket[B[1,2], B[3,4], B[5,6]], Blanket[B[1,5], B[2,3], B[4,6]]],
        [Blanket[B[1,2], B[3,4,5,6]], Blanket[B[1], B[2,3,5], B[4,6]]],
      ]
    end
  end
  end end
