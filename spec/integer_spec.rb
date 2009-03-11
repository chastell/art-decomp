describe Integer do

  it 'should return set bits' do
    0.bits.should        == []
    0b111.bits.should    == [0,1,2]
    0b1000.bits.should   == [3]
    0b101010.bits.should == [1,3,5]
    (2**80).bits.should  == [80]
  end

end
