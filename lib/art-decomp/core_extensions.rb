require_relative 'core_extensions/enumerable'
require_relative 'core_extensions/file'
require_relative 'core_extensions/integer'
require_relative 'core_extensions/set'
require_relative 'core_extensions/string'

class Array
  include ArtDecomp::CoreExtensions::Enumerable
end

class File
  extend ArtDecomp::CoreExtensions::File::ClassMethods
end

class Integer
  include ArtDecomp::CoreExtensions::Integer
end

class Set
  include ArtDecomp::CoreExtensions::Enumerable
  include ArtDecomp::CoreExtensions::Set
end
