module ArtDecomp class QvGenerator::GraphMerging < QvGenerator

  def each u, v, beta_qu
    beta_u = @fsm.beta_x u
    beta_v = @fsm.beta_x v
    qv_graph = Graph.new @beta_q, @beta_f.seps - beta_u.seps - beta_qu.seps - beta_v.seps
    loop do
      beta_qv = Blanket.new qv_graph.vertices
      g_graph = Graph.new beta_qv * beta_v, @beta_f.seps - beta_u.seps - beta_qu.seps
      beta_g = Blanket.new g_graph.merge_until_complete!.vertices
      yield [beta_qv, beta_g]
      break if qv_graph.complete?
      qv_graph.merge_by_vertex_degrees!
    end
  end

end end
