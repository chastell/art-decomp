module ArtDecomp class QvGenerator::GraphMerging
  def blankets fsm, u, v, beta_qu
    beta_u   = fsm.beta_x u
    beta_v   = fsm.beta_x v
    qv_graph = Graph.new fsm.beta_q, fsm.beta_f.seps - beta_u.seps - beta_qu.seps - beta_v.seps
    Enumerator.new do |yielder|
      loop do
        beta_qv = Blanket.new qv_graph.vertices
        g_graph = Graph.new beta_qv * beta_v, fsm.beta_f.seps - beta_u.seps - beta_qu.seps
        beta_g  = Blanket.new g_graph.merge_until_complete!.vertices
        yielder.yield [beta_qv, beta_g]
        break if qv_graph.complete?
        qv_graph.merge_by_vertex_degrees!
      end
    end
  end
end end
