require_relative '../../spec_helper'

module ArtDecomp describe CoreExtensions::File do

  describe '.dump_object' do

    it 'marshals the given object to a file at the given path' do
      file = Tempfile.new 'File.dump_object'
      File.dump_object [:answer, 42, 'Deep Thought'], file.path
      Marshal.load(File.read(file.path)).must_equal [:answer, 42, 'Deep Thought']
    end

  end

end end
