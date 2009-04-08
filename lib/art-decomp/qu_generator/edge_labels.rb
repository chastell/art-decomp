module ArtDecomp::QuGenerator class EdgeLabels

  def initialize fsm, archs
    @fsm = fsm
  end

  def each u, v
    seps = @fsm.beta_f.seps - @fsm.beta_x(u).seps
    @graph = Graph.new @fsm.beta_q, seps
    initial_merge
    yield Blanket.new @graph.vertices
    while @graph.vertices.size > 1
      @graph.merge_by_edge_labels! do |a, b|
        [seps.r_adm(a|b), (Blanket[a,b].seps & seps).size]
      end
      yield Blanket.new @graph.vertices
    end
  end

  private

  def initial_merge
    @graph.merge_until_complete!
  end

end end
