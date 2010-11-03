describe File do

  it 'should be able to marshal an object to a given file' do
    file = Tempfile.new rand.to_s
    File.dump_object [:answer, 42, 'Deep Thought'], file.path
    Marshal.load(File.read(file.path)).should == [:answer, 42, 'Deep Thought']
  end

  it 'should be able to dump arbitrary data to a given file' do
    file = Tempfile.new rand.to_s
    File.write_data '42', file.path
    File.read(file.path).should == '42'
  end

end
