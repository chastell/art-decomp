module ArtDecomp describe Sep do

  context '.[]' do

    it 'constructs an Integer with set bits representing the separation' do
      Sep[1,2].should  == 0b110
      Sep[0,69].should == 2**69 + 0b1
    end

  end

  context '#hash' do

    it 'hashes uniformly' do
      Sep[1,2].hash.should  == 0b110.hash
      Sep[0,69].hash.should == (2**69 + 0b1).hash
    end

  end

end end
