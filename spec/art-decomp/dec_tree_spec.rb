require_relative '../spec_helper'

module ArtDecomp describe DecTree do
  describe '#==' do
    it 'verifies tree equality' do
      DecTree.new(['foo', 'bar']).must_equal DecTree.new ['foo', 'bar']
      DecTree.new(['foo', 'bar']).wont_equal DecTree.new ['bar', 'foo']
    end
  end
end end
