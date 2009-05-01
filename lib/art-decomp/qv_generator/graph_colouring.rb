module ArtDecomp::QvGenerator class GraphColouring

  def initialize fsm, archs
    @fsm, @beta_f, @beta_q = fsm, fsm.beta_f, fsm.beta_q
  end

  def each u, v, beta_qu
    beta_u  = @fsm.beta_x u
    beta_v  = @fsm.beta_x v
    beta_g  = Graph.new(@beta_q * beta_v, @beta_f.seps - beta_u.seps - beta_qu.seps).blanket_from_colouring
    beta_qv = Graph.new(@beta_q, beta_g.seps - beta_v.seps).blanket_from_colouring
    yield beta_qv, beta_g
    beta_qv = Graph.new(@beta_q, @beta_f.seps - beta_u.seps - beta_qu.seps - beta_v.seps).blanket_from_colouring
    beta_g  = Graph.new(beta_qv * beta_v, @beta_f.seps - beta_u.seps - beta_qu.seps).blanket_from_colouring
    yield beta_qv, beta_g
  end

end end
