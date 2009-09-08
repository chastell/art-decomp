# encoding: UTF-8

module ArtDecomp describe Blanket do

  it 'should be easily instantiable, properly comparable and usable as a Set element' do
    Blanket[B[], B[0], B[1,2]].should      == Blanket.new([B[1,2], B[0]])
    Blanket[B[], B[0], B[1,2]].hash.should == Blanket.new([B[1,2], B[0]]).hash
    Blanket[B[], B[0], B[1,2]].should     eql Blanket.new([B[1,2], B[0]])
  end

  it 'should expose its internal ints variable and it should be immutable' do
    Blanket[B[1,2], B[3,4]].ints.should == Set[B[3,4], B[1,2]]
    Blanket[B[1,2], B[3,4]].ints.should be_frozen
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

  it 'should properly expose the separations it provides/requires' do
    Blanket[].seps.should                   == Set[]
    Blanket[B[1]].seps.should               == Set[]
    Blanket[B[1], B[2], B[]].seps.should    == Set[Sep[1,2]]
    Blanket[B[1,2], B[3,4]].seps.should     == Set[Sep[1,3], Sep[1,4], Sep[2,3], Sep[2,4]]
    Blanket[B[1,2,3], B[2,3,4]].seps.should == Set[Sep[1,4]]
  end

  it 'should properly report its size' do
    Blanket[].size.should                   == 0
    Blanket[B[1]].size.should               == 1
    Blanket[B[1], B[2], B[]].size.should    == 2
    Blanket[B[1,2,3], B[2,3,4]].size.should == 2
  end

  it 'should return the Blanket’s ‘natural’ encoding, based on the provided subblock' do
    blanket = Blanket[B[0,1,2], B[1,2,3], B[2,3,4]]
    blanket.encoding(B[0,1,2]).should == '00'
    blanket.encoding(B[1,2,3]).should == '01'
    blanket.encoding(B[2,3,4]).should == '10'
    blanket.encoding(B[2]).should     == '--'
    lambda { blanket.encoding(B[1,2]) }.should raise_error(AmbiguousEncodingQuery, 'ambiguous encoding query: block 1,2')
  end

  it 'should return the Blanket’s ‘natural’ encodings in an Array if so asked' do
    blanket = Blanket[B[0,1,2], B[1,2,3], B[2,3,4]]
    blanket.encodings(B[0,1,2]).should == ['00']
    blanket.encodings(B[1,2,3]).should == ['01']
    blanket.encodings(B[2,3,4]).should == ['10']
    blanket.encodings(B[2]).should     == ['--']
    blanket.encodings(B[1,2]).should   == ['00', '01']
  end

  it 'should report how many physical pins it uses' do
    Blanket[B[]].pins.should                                          == 0
    Blanket[B[1]].pins.should                                         == 0
    Blanket[B[1,2]].pins.should                                       == 0
    Blanket[B[1],B[2]].pins.should                                    == 1
    Blanket[B[1],B[2],B[3]].pins.should                               == 2
    Blanket[B[1,2],B[3,4],B[5,6],B[7]].pins.should                    == 2
    Blanket[B[1],B[2],B[3],B[4],B[5]].pins.should                     == 3
    Blanket[B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8]].pins.should      == 3
    Blanket[B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9]].pins.should == 4
  end

end end
