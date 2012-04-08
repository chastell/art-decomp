require 'set'
require 'yaml'

module ArtDecomp
  DontCare = :-
end

Dir["#{File.dirname(__FILE__)}/**/*.rb"].sort.each { |f| require f }

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
