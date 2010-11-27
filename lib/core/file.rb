class File

  def self.dump_object object, path
    open(path, 'w') { |file| file.write Marshal.dump object }
  end

end
