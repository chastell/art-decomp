describe File do

  context '.dump_object' do

    it 'marshals the given object to a file at the given file' do
      file = Tempfile.new 'File.dump_object'
      File.dump_object [:answer, 42, 'Deep Thought'], file.path
      Marshal.load(File.read(file.path)).should == [:answer, 42, 'Deep Thought']
    end

  end

  it 'should be able to dump arbitrary data to a given file' do
    file = Tempfile.new rand.to_s
    File.write_data '42', file.path
    File.read(file.path).should == '42'
  end

end
