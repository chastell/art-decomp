module ArtDecomp::QvGenerator class GraphMerging

  def initialize fsm, archs
    @fsm, @beta_f, @beta_q = fsm, fsm.beta_f, fsm.beta_q
  end

  def each u, v, beta_qu
    beta_u = @fsm.beta_x u
    beta_v = @fsm.beta_x v
    g_graph = Graph.new @beta_q * beta_v, @beta_f.seps - beta_u.seps - beta_qu.seps
    beta_g = Blanket.new g_graph.merge_until_complete!.vertices
    qv_graph = Graph.new @beta_q, beta_g.seps - beta_v.seps
    beta_qv = Blanket.new qv_graph.merge_until_complete!.vertices
    yield [beta_qv, beta_g]
  end

end end
