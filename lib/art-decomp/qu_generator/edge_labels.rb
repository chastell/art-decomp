module ArtDecomp class QuGenerator::EdgeLabels

  def blankets fsm, u, v
    Enumerator.new do |yielder|
      seps = fsm.beta_f.seps - fsm.beta_x(u).seps
      @graph = Graph.new fsm.beta_q, seps
      initial_merge
      yielder.yield Blanket.new @graph.vertices
      while @graph.vertices.size > 1
        @graph.merge_by_edge_labels! do |a, b|
          [seps.r_adm(a|b), (Blanket[a,b].seps & seps).size]
        end
        yielder.yield Blanket.new @graph.vertices
      end
    end
  end

  private

  def initial_merge
    @graph.merge_until_complete!
  end

end end
