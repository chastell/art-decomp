module ArtDecomp module CoreExtensions::File

  module ClassMethods

    def dump_object object, path
      open(path, 'w') { |file| file.write Marshal.dump object }
    end

  end

end end
