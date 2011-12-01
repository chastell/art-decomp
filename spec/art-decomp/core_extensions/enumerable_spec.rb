require_relative '../../spec_helper'

module ArtDecomp describe CoreExtensions::Enumerable do
  describe '#pairs' do
    it 'provides an Enumerator for consecutive Array pairs' do
      pairs = [1,2,3,4].extend(CoreExtensions::Enumerable).pairs
      pairs.must_be_instance_of Enumerator
      pairs.to_a.must_equal [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
    end

    it 'provides an Enumerator for consecutive Set pairs' do
      pairs = Set[1,2,3,4].pairs
      pairs.must_be_instance_of Enumerator
      pairs.to_a.must_equal [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
    end
  end
end end
