module ArtDecomp describe B do

  context 'when representing ‘set bits’ concept' do

    it 'should provide proper representation (also across the Fixnum/Bignum boundary)' do
      B[].should     == 0b0
      B[0].should    == 0b1
      B[5,8].should  == 0b100100000
      B[30].should   == 2**30
      B[40].should   == 2**40
      B[1,69].should == 2**69 + 0b10
    end

    it 'should uniformly work inside Sets (also across the Fixnum/Bignum boundary)' do
      B[].hash.should     == 0b0.hash
      B[0].hash.should    == 0b1.hash
      B[5,8].hash.should  == 0b100100000.hash
      B[30].hash.should   == (2**30).hash
      B[40].hash.should   == (2**40).hash
      B[1,69].hash.should == (2**69 + 0b10).hash
    end

  end

end end
