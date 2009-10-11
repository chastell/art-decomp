class File

  def self.dump_object object, path
    write_data Marshal.dump(object), path
  end

  def self.write_data data, path
    self.open(path, 'w') { |f| f << data }
  end

end
