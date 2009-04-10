module ArtDecomp class Graph

  attr_reader :edges, :vertices

  def initialize blanket, seps
    @vertices = blanket.ints.dup
    @edges    = Set[]
    seps.each do |sep|
      @vertices.every_pair do |a, b|
        @edges << Set[a,b] unless (a & sep).zero? or (b & sep).zero? or (a | b) & sep != sep
      end
    end
  end

  def blanket_from_colouring
    colours = {}
    @vertices.sort_by { |vert| degree vert }.reverse_each do |vertex|
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
    2 * @edges.size == @vertices.size * (@vertices.size - 1)
  end

  def degree vertex
    @edges.count { |edge| edge.include? vertex }
  end

  def merge_by_edge_labels!
    return if @vertices.size == 1
    pins = @vertices.size.log2_ceil
    until @vertices.size.log2_ceil < pins
      # FIXME: edge labels can/should be cached from previous computations
      a, b = *@edges.sort_by { |edge| yield *edge }.first
      merge! a, b
    end
  end

  def merge_by_vertex_degrees!
    pins = @vertices.size.log2_ceil
    until @vertices.size.log2_ceil < pins or complete?
      @vertices.sort_by { |vert| degree vert }.every_pair do |a, b|
        next if @edges.include? Set[a, b]
        merge! a, b
        break
      end
    end
  end

  def merge_until_complete!
    merge_by_vertex_degrees! until complete?
  end

  private

  def adjacent *vertices
    return Set[] if @edges.all? { |edge| (edge & vertices).empty? }
    @edges.reject { |edge| (edge & vertices).empty? }.inject(:|) - vertices
  end

  def merge! a, b
    adjacent = adjacent a, b
    @vertices.subtract [a, b]
    @vertices.add a|b
    @edges.delete_if { |edge| edge.include? a or edge.include? b }
    @edges.merge adjacent.map { |vert| Set[a|b, vert] }
  end

end end
