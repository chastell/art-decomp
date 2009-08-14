module ArtDecomp describe Arch do

  it 'should be instantiable Array-style (and compare and hash properly)' do
    Arch[5,1].should == Arch.new(5, 1)
    Arch[5,2].should_not == Arch[5,1]
    Arch[4,1].should_not == Arch[5,1]
    Arch[5,1].hash.should == Arch[5,1].hash
  end

end end
