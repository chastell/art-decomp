describe Blanket do

  it 'should be easily instantiable, properly comparable and usable as a Set element' do
    Blanket[B[], B[0], B[1,2]].should      == Blanket.new([B[1,2], B[0]])
    Blanket[B[], B[0], B[1,2]].hash.should == Blanket.new([B[1,2], B[0]]).hash
  end

  it 'should be properly instantiable from an Array' do
      blanket = Blanket.from_array [:b, DontCare, :a, :c, :b, :a, :c]
      blanket.should == Blanket[B[0,1,4], B[1,2,5], B[1,3,6]]
  end

  it 'should be inspectable and return a self-instanting form' do
    Blanket[B[]].inspect.should == 'Blanket[]'
    Blanket[B[1,2], B[0]].inspect.should == 'Blanket[B[0], B[1,2]]'
  end

  it 'should be multipliable by other Blankets' do
    b1 = Blanket[B[1,2,3], B[4,5,6]]
    b2 = Blanket[B[1,2], B[3,4], B[5,6]]
    (b1 * b2).should == Blanket[B[1,2], B[3], B[4], B[5,6]]
  end

end
