describe File do

  it 'should be able to marshal an object to a given file' do
    file = Tempfile.new rand
    File.dump_object file.path, [:answer, 42, 'Deep Thought']
    Marshal.load(File.read(file.path)).should == [:answer, 42, 'Deep Thought']
  end

  it 'should be able to dump arbitrary data to a given file' do
    file = Tempfile.new rand
    File.write_data file.path, '42'
    File.read(file.path).should == '42'
  end

end
