module ArtDecomp

  DontCare = :-

  module QuGenerator
  end

  module QvGenerator
  end

  module UVGenerator
  end

end



require 'set'
require 'yaml'

require_relative 'core/enumerable'
require_relative 'core/file'
require_relative 'core/integer'
require_relative 'core/set'
require_relative 'core/string'

require_relative 'art-decomp/arch'
require_relative 'art-decomp/b'
require_relative 'art-decomp/bipainter'
require_relative 'art-decomp/blanket'
require_relative 'art-decomp/decomposer'
require_relative 'art-decomp/decomposition'
require_relative 'art-decomp/exceptions'
require_relative 'art-decomp/executable'
require_relative 'art-decomp/fsm'
require_relative 'art-decomp/graph'
require_relative 'art-decomp/kiss'
require_relative 'art-decomp/qu_generator/block_table'
require_relative 'art-decomp/qu_generator/edge_labels'
require_relative 'art-decomp/qv_generator/bipainting'
require_relative 'art-decomp/qv_generator/graph_colouring'
require_relative 'art-decomp/qv_generator/graph_merging'
require_relative 'art-decomp/sep'
require_relative 'art-decomp/uv_relevance_generator'
require_relative 'art-decomp/uv_generator/braindead'
require_relative 'art-decomp/uv_generator/general_relevance'
require_relative 'art-decomp/uv_generator/unique_relevance'
require_relative 'art-decomp/vhdl'
