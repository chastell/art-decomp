$LOAD_PATH << File.dirname(__FILE__)

require 'set'
require 'yaml'

module ArtDecomp

  DontCare = :-

  autoload :AmbiguousEncodingQuery, 'art-decomp/ambiguous_encoding_query'
  autoload :Arch,                   'art-decomp/arch'
  autoload :B,                      'art-decomp/b'
  autoload :Bipainter,              'art-decomp/bipainter'
  autoload :Blanket,                'art-decomp/blanket'
  autoload :Decomposer,             'art-decomp/decomposer'
  autoload :Decomposition,          'art-decomp/decomposition'
  autoload :Executable,             'art-decomp/executable'
  autoload :FSM,                    'art-decomp/fsm'
  autoload :Graph,                  'art-decomp/graph'
  autoload :KISS,                   'art-decomp/kiss'
  autoload :PaintingError,          'art-decomp/painting_error'
  autoload :Sep,                    'art-decomp/sep'
  autoload :UVRelevanceGenerator,   'art-decomp/uv_relevance_generator'
  autoload :VHDL,                   'art-decomp/vhdl'

  module CoreExtensions
    autoload :Enumerable, 'art-decomp/core_extensions/enumerable'
    autoload :File,       'art-decomp/core_extensions/file'
    autoload :Integer,    'art-decomp/core_extensions/integer'
    autoload :Set,        'art-decomp/core_extensions/set'
    autoload :String,     'art-decomp/core_extensions/string'
  end

  module QuGenerator
    autoload :BlockTable, 'art-decomp/qu_generator/block_table'
    autoload :EdgeLabels, 'art-decomp/qu_generator/edge_labels'
  end

  module QvGenerator
    autoload :Bipainting,     'art-decomp/qv_generator/bipainting'
    autoload :GraphColouring, 'art-decomp/qv_generator/graph_colouring'
    autoload :GraphMerging,   'art-decomp/qv_generator/graph_merging'
  end

  module UVGenerator
    autoload :Braindead,        'art-decomp/uv_generator/braindead'
    autoload :GeneralRelevance, 'art-decomp/uv_generator/general_relevance'
    autoload :UniqueRelevance,  'art-decomp/uv_generator/unique_relevance'
  end

end

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

class String
  include ArtDecomp::CoreExtensions::String
end
