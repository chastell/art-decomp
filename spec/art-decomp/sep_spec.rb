describe Sep do

  it 'should be an Integer with bits representing the separated values' do
    Sep[1,2].should  == 0b110
    Sep[0,80].should == 2**80 + 0b1
  end

  it 'should be usable as a Set element' do
    Sep[1,2].hash.should  == 0b110.hash
    Sep[0,80].hash.should == (2**80 + 0b1).hash
  end

end
