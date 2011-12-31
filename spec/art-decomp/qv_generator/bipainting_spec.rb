require_relative '../../spec_helper'

module ArtDecomp describe QvGenerator::Bipainting do
  describe '#blankets' do
    it 'uses graph bicolouring' do
      verify_qv_blankets QvGenerator::Bipainting.new, [
        [Blanket[B[1,2], B[3,4,5,6]], Blanket[B[1], B[2,3,5], B[4,6]]],
      ]
    end
  end
end end
