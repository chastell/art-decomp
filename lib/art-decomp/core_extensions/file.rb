module ArtDecomp module CoreExtensions module File
  module ClassMethods
    def dump_object object, path
      open(path, 'w') { |file| Marshal.dump object, file }
    end
  end
end end end
