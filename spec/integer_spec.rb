describe Integer do

  it 'should return set bits' do
    0.bits.should        == []
    0b111.bits.should    == [0,1,2]
    0b1000.bits.should   == [3]
    0b101010.bits.should == [1,3,5]
    (2**80).bits.should  == [80]
  end

  it 'should return ceil of base-2 logarithm' do
    0.log2_ceil.should == 0
    1.log2_ceil.should == 0
    2.log2_ceil.should == 1
    3.log2_ceil.should == 2
    4.log2_ceil.should == 2
    5.log2_ceil.should == 3
    8.log2_ceil.should == 3
  end

end
