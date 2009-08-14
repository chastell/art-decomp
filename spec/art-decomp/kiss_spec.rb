module ArtDecomp describe KISS do

  it 'should sort the provided KISS entries' do
    kiss = KISS.new ['1 1', '0 0']
    kiss.formatted.should == "0 0\n1 1\n"
  end

  it 'should drop non-unique entries' do
    kiss = KISS.new ['0 0', '0 0']
    kiss.formatted.should == "0 0\n"
  end

  it 'should drop overlapping entries' do
    kiss = KISS.new ['0-0 0', '010 0', '1-1 1', '--1 1']
    kiss.formatted.should == "--1 1\n0-0 0\n"
  end

end end
