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
    @vertices.sort_by { |v| degree(v) }.reverse_each do |vertex|
      forbidden = adjacent(vertex).map { |v| colours[v] }.to_set
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
    @edges.count { |e| e.include? vertex }
  end

  def merge_by_edge_labels!
    pins = @vertices.size.log2_ceil
    until @vertices.size.log2_ceil < pins
      a, b = *@edges.sort_by { |e| yield *e }.first
      merge! a, b
    end
  end

  def merge_until_complete!
    until complete?
      @vertices.sort_by { |v| degree v }.every_pair do |a, b|
        next if @edges.include? Set[a, b]
        merge! a, b
        break
      end
    end
  end

  private

  def adjacent vertex
    return Set[] unless @edges.any? { |e| e.include? vertex }
    @edges.select { |e| e.include? vertex }.inject(:|) - Set[vertex]
  end

  def merge! a, b
    adjacent = adjacent(a) + adjacent(b) - Set[a, b]
    @vertices.subtract [a, b]
    @vertices << (a|b)
    @edges.delete_if { |e| e.include? a or e.include? b }
    adjacent.each { |v| @edges << Set[a|b, v] }
  end

end end
