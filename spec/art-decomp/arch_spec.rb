module ArtDecomp describe Arch do

  context '.[]' do

    it 'instantiates Arch Array-style' do
      Arch[5,1].should == Arch.new(5, 1)
    end

  end

  context '#==' do

    it 'compares I/O counts' do
      Arch[5,1].should     == Arch[5,1]
      Arch[5,2].should_not == Arch[5,1]
      Arch[4,1].should_not == Arch[5,1]
    end

  end

  context '#eql?' do

    it 'compares I/O counts' do
      Arch[5,1].should eql Arch[5,1]
    end

  end

  context '#hash' do

    it 'is I/O-count-based' do
      Arch[5,1].hash.should == Arch[5,1].hash
    end

  end

  context '#to_s' do

    it 'has an I/O String representation' do
      Arch[5,1].to_s.should == '5/1'
      Arch[4,2].to_s.should == '4/2'
    end

  end

  it 'should report how many cells of given Archs it requires' do
    Arch[4,3].cells(Set[Arch[4,2], Arch[5,1]]).should == 2
    Arch[4,3].cells(Set[Arch[5,1]]).should            == 3
    Arch[5,3].cells(Set[Arch[4,3]]).should be_nil
    Arch[5,3].cells(Set[Arch[5,2]]).should            == 2
  end

end end
