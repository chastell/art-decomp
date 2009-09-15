module ArtDecomp describe Arch do

  it 'should be instantiable Array-style (and compare and hash properly)' do
    Arch[5,1].should == Arch.new(5, 1)
    Arch[5,2].should_not == Arch[5,1]
    Arch[4,1].should_not == Arch[5,1]
    Arch[5,1].hash.should == Arch[5,1].hash
    Arch[5,1].should eql Arch[5,1]
  end

  it 'should have a common String representation' do
    Arch[5,1].to_s.should == '5/1'
    Arch[4,2].to_s.should == '4/2'
  end

  it 'should report how many cells of given Archs it requires' do
    Arch[4,3].cells(Set[Arch[4,2], Arch[5,1]]).should == 2
    Arch[4,3].cells(Set[Arch[5,1]]).should            == 3
    Arch[5,3].cells(Set[Arch[4,3]]).should be_nil
    Arch[5,3].cells(Set[Arch[5,2]]).should            == 2
  end

end end
