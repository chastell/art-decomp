require_relative '../spec_helper'

module ArtDecomp describe DecTree do
  let(:dec_tree) { DecTree.new ['foo', 'bar'] }

  describe '#==' do
    it 'verifies tree equality' do
      dec_tree.must_equal DecTree.new ['foo', 'bar']
      dec_tree.wont_equal DecTree.new ['bar', 'foo']
    end
  end

  describe '#<<' do
    it 'appends elements' do
      dec_tree << 'baz'
      dec_tree.must_equal DecTree.new ['foo', 'bar', 'baz']
    end
  end

  describe '#pop' do
    it 'drops elements' do
      dec_tree.pop
      dec_tree.must_equal DecTree.new ['foo']
    end
  end
end end
