module ArtDecomp class Graph

  attr_reader :edges, :vertices

  def initialize blanket, separations
    @vertices = blanket.ints.dup
    @edges    = Set[]
    separations.each do |sep|
      @vertices.every_pair do |a, b|
        @edges << Set[a,b] unless (a & sep).zero? or (b & sep).zero? or (a | b) & sep != sep
      end
    end
  end

  def blanket_from_colouring
    colours = {}
    @vertices.sort_by { |v| degree(v) }.reverse_each do |vertex|
      forbidden = adjacent(vertex).map { |v| colours[v] }.to_set
      colour = :a
      colour = colour.next while forbidden.include? colour
      colours[vertex] = colour
    end
    blocks = Hash.new 0
    colours.each { |vertex, colour| blocks[colour] |= vertex }
    Blanket.new blocks.values
  end

  def degree vertex
    @edges.count { |e| e.include? vertex }
  end

  private

  def adjacent vertex
    return Set[] unless @edges.any? { |e| e.include? vertex }
    @edges.select { |e| e.include? vertex }.inject(:|).delete vertex
  end

end end
