module ArtDecomp class Graph

  def initialize blanket, seps
    vertices = blanket.ints.dup
    vertices.delete_if { |this| vertices.any? { |other| other != this and other & this == this } }
    @neighbours = Hash[vertices.map { |vertex| [vertex, Set[]] }]
    relevant = Hash[vertices.map { |v| [v, seps.select { |s| v&s != 0 and v&s != s }.to_set] }]
    vertices.pairs.each do |a, b|
      if (relevant[a] & relevant[b]).any? { |s| a&s != b&s }
        @neighbours[a] << b
        @neighbours[b] << a
      end
    end
  end

  def adjacent *vertices
    vertices.map { |vertex| @neighbours[vertex] }.inject(:|) - vertices
  end

  def blanket_from_colouring
    colours = {}
    @neighbours.keys.sort_by { |vert| [-degree(vert), vert] }.each do |vertex|
      forbidden = adjacent(vertex).map { |vert| colours[vert] }.to_set
      # FIXME: consider selecting colours on the least-popular-first basis
      colour = :a
      colour = colour.next while forbidden.include? colour
      colours[vertex] = colour
    end
    blocks = Hash.new 0
    colours.each { |vertex, colour| blocks[colour] |= vertex }
    Blanket.new blocks.values
  end

  def complete?
    @neighbours.values.map(&:size).inject(:+) == @neighbours.size * (@neighbours.size - 1)
  end

  def degree vertex
    @neighbours[vertex].size
  end

  def edges
    @neighbours.map { |v, adjacents| adjacents.map { |adj| Set[v, adj] } }.flatten.to_set
  end

  def merge_by_edge_labels!
    return self if @neighbours.size == 1
    pins = @neighbours.size.log2_ceil
    until @neighbours.size.log2_ceil < pins
      # FIXME: edge labels can/should be cached from previous computations
      a, b = *edges.sort_by { |edge| yield *edge }.first
      merge! a, b
    end
    self
  end

  def merge_by_vertex_degrees!
    pins = @neighbours.size.log2_ceil
    until @neighbours.size.log2_ceil < pins or complete?
      a, b = *@neighbours.keys.sort_by { |v| -degree(v) }.pairs.find { |v1, v2| not @neighbours[v1].include? v2 }
      merge! a, b
    end
    self
  end

  def merge_until_complete!
    merge_by_vertex_degrees! until complete?
    self
  end

  def vertices
    @neighbours.keys.to_set
  end

  private

  def merge! a, b
    new = a | b
    adjs = adjacent(a) | adjacent(b)
    adjs.each { |adj| @neighbours[adj] << new }
    @neighbours[new] = adjs
    @neighbours.delete(a).each { |adj| @neighbours[adj].delete a } unless a == new
    @neighbours.delete(b).each { |adj| @neighbours[adj].delete b } unless b == new
  end

end end
