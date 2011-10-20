module ArtDecomp describe CoreExtensions::Integer do

  describe '#bits' do

    it 'returns set bit positions' do
      0.bits.should        == []
      0b111.bits.should    == [0,1,2]
      0b1000.bits.should   == [3]
      0b101010.bits.should == [1,3,5]
      (2**69).bits.should  == [69]
    end

  end

  describe '#log2_ceil' do

    it 'returns ceil of base-two logarithm from self' do
      (0..9).map(&:log2_ceil).should == [0,0,1,2,2,3,3,3,3,4]
      (2**69).log2_ceil.should == 69
    end

  end

end end