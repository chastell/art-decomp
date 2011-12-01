require 'set'
require 'yaml'

module ArtDecomp
  DontCare = :-

  module CoreExtensions; end
  module QuGenerator;    end
  module QvGenerator;    end
  module UVGenerator;    end
end

require_relative 'art-decomp/ambiguous_encoding_query'
require_relative 'art-decomp/arch'
require_relative 'art-decomp/b'
require_relative 'art-decomp/bipainter'
require_relative 'art-decomp/blanket'
require_relative 'art-decomp/decomposer'
require_relative 'art-decomp/decomposition'
require_relative 'art-decomp/executable'
require_relative 'art-decomp/fsm'
require_relative 'art-decomp/graph'
require_relative 'art-decomp/kiss'
require_relative 'art-decomp/painting_error'
require_relative 'art-decomp/sep'
require_relative 'art-decomp/uv_relevance_generator'
require_relative 'art-decomp/vhdl'

require_relative 'art-decomp/core_extensions/enumerable'
require_relative 'art-decomp/core_extensions/file'
require_relative 'art-decomp/core_extensions/integer'
require_relative 'art-decomp/core_extensions/set'
require_relative 'art-decomp/core_extensions/string'

require_relative 'art-decomp/qu_generator/block_table'
require_relative 'art-decomp/qu_generator/edge_labels'

require_relative 'art-decomp/qv_generator/bipainting'
require_relative 'art-decomp/qv_generator/graph_colouring'
require_relative 'art-decomp/qv_generator/graph_merging'

require_relative 'art-decomp/uv_generator/braindead'
require_relative 'art-decomp/uv_generator/general_relevance'
require_relative 'art-decomp/uv_generator/unique_relevance'

class File
  extend ArtDecomp::CoreExtensions::File::ClassMethods
end

class Integer
  include ArtDecomp::CoreExtensions::Integer
end

class Set
  include ArtDecomp::CoreExtensions::Set
end
