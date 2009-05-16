class File

  def self.dump_object path, object
    File.open(path, 'w') { |f| f << Marshal.dump(object) }
  end

  def self.write_data path, data
    File.open(path, 'w') { |f| f << data }
  end

end
