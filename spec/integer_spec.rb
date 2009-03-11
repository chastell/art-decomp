describe Integer do

  it 'should return set bits' do
    0.bits.should        == []
    0b111.bits.should    == [0,1,2]
    0b1000.bits.should   == [3]
    0b101010.bits.should == [1,3,5]
    (2**80).bits.should  == [80]
  end

  it 'should return ceil of base-2 logarithm' do
    (0..9).map(&:log2_ceil).should == [0,0,1,2,2,3,3,3,3,4]
    (2**69).log2_ceil.should == 69
  end

end
