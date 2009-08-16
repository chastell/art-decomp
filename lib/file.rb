class File

  def self.dump_object path, object
    write_data path, Marshal.dump(object)
  end

  def self.write_data path, data
    self.open(path, 'w') { |f| f << data }
  end

end
