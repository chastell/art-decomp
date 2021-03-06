require 'erb'
require 'forwardable'
require 'ostruct'
require 'set'
require 'yaml'

module ArtDecomp
  DontCare = :- # rubocop:disable ConstantName
  Infinity = Float::INFINITY
end

require_relative 'art-decomp/ambiguous_encoding_query'
require_relative 'art-decomp/arch'
require_relative 'art-decomp/b'
require_relative 'art-decomp/bipainter'
require_relative 'art-decomp/blanket'
require_relative 'art-decomp/core_extensions'
require_relative 'art-decomp/dec_tree'
require_relative 'art-decomp/dec_tree_generator'
require_relative 'art-decomp/decomposer'
require_relative 'art-decomp/decomposition'
require_relative 'art-decomp/fsm'
require_relative 'art-decomp/graph'
require_relative 'art-decomp/kiss'
require_relative 'art-decomp/painting_error'
require_relative 'art-decomp/qu_generators/block_table'
require_relative 'art-decomp/qu_generators/edge_labels'
require_relative 'art-decomp/qv_generators/bipainting'
require_relative 'art-decomp/qv_generators/graph_colouring'
require_relative 'art-decomp/qv_generators/graph_merging'
require_relative 'art-decomp/sep'
require_relative 'art-decomp/sep_matrix'
require_relative 'art-decomp/uv_relevance_generator'
require_relative 'art-decomp/uv_generators/braindead'
require_relative 'art-decomp/uv_generators/general_relevance'
require_relative 'art-decomp/uv_generators/relative_relevance'
require_relative 'art-decomp/uv_generators/unique_relevance'
require_relative 'art-decomp/vhdl'
