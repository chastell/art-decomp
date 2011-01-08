require 'set'
require 'yaml'

require_relative 'core/enumerable'
require_relative 'core/file'
require_relative 'core/integer'
require_relative 'core/set'
require_relative 'core/string'

require_relative 'art-decomp/exceptions'

module ArtDecomp

  DontCare = :-

  autoload :Arch,                 'art-decomp/arch'
  autoload :B,                    'art-decomp/b'
  autoload :Bipainter,            'art-decomp/bipainter'
  autoload :Blanket,              'art-decomp/blanket'
  autoload :Decomposer,           'art-decomp/decomposer'
  autoload :Decomposition,        'art-decomp/decomposition'
  autoload :Executable,           'art-decomp/executable'
  autoload :FSM,                  'art-decomp/fsm'
  autoload :Graph,                'art-decomp/graph'
  autoload :KISS,                 'art-decomp/kiss'
  autoload :Sep,                  'art-decomp/sep'
  autoload :UVRelevanceGenerator, 'art-decomp/uv_relevance_generator'
  autoload :VHDL,                 'art-decomp/vhdl'

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
