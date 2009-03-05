describe Blanket do

  it 'should be easily instantiable, properly comparable and usable as a Set element' do
    Blanket[B[], B[0], B[1,2]].should      == Blanket.new([B[1,2], B[0]])
    Blanket[B[], B[0], B[1,2]].hash.should == Blanket.new([B[1,2], B[0]]).hash
  end

  it 'should be properly instantiable from an Array' do
      blanket = Blanket.from_array [:b, DontCare, :a, :c, :b, :a, :c]
      blanket.should == Blanket[B[0,1,4], B[1,2,5], B[1,3,6]]
  end

end
