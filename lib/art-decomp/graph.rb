module ArtDecomp class Graph

  def initialize blanket, separations
    @vertices = {}
    @edges    = {}
    blanket.ints.each { |i| @vertices[i] = nil }
    separations.each do |sep|
      vertices.every_pair do |a, b|
        @edges[Set[a,b]] = nil unless (a & sep).zero? or (b & sep).zero? or (a | b) & sep != sep
      end
    end
  end

  def degree vertex
    edges.select { |e| e.include? vertex }.size
  end

  def edges
    @edges.keys.to_set
  end

  def vertices
    @vertices.keys.to_set
  end

end end
