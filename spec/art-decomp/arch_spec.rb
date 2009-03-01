describe Arch do

  it 'should be instantiable Array-style (and compare properly)' do
    Arch[5,1].should == Arch.new(5, 1)
  end

end
