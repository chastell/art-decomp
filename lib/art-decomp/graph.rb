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

  def degree vertex
    @edges.select { |e| e.include? vertex }.size
  end

end end
