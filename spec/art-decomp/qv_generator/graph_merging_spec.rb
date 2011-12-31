require_relative '../../spec_helper'

module ArtDecomp describe QvGenerator::GraphMerging do
  describe '#blankets' do
    it 'merges vertices of the proper incompatibility graphs' do
      verify_qv_blankets QvGenerator::GraphMerging.new
    end
  end
end end
