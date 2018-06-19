require_relative '../../spec_helper'

module ArtDecomp
  describe CoreExtensions::Integer do
    describe '#bits' do
      it 'returns set bit positions' do
        0.bits.must_equal        []
        0b111.bits.must_equal    [0,1,2]
        0b1000.bits.must_equal   [3]
        0b101010.bits.must_equal [1,3,5]
        (2**69).bits.must_equal  [69]
      end
    end

    describe '#log2_ceil' do
      it 'returns ceil of base-two logarithm from self' do
        (0..9).map(&:log2_ceil).must_equal [0,0,1,2,2,3,3,3,3,4]
        (2**69).log2_ceil.must_equal       69
      end
    end
  end end
