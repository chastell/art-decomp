require_relative '../../spec_helper'

module ArtDecomp describe QvGenerator::GraphColouring do
  describe '#blankets' do
    it 'uses graph colouring of the proper incompatibility graphs' do
      verify_qv_blankets QvGenerator::GraphColouring.new
    end
  end
end end
