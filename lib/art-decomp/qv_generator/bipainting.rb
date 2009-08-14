module ArtDecomp class QvGenerator::Bipainting

  def initialize fsm, archs
    @fsm, @beta_f, @beta_q = fsm, fsm.beta_f, fsm.beta_q
  end

  def each u, v, beta_qu
    beta_u = @fsm.beta_x u
    beta_v = @fsm.beta_x v
    bipainter = Bipainter.new @beta_q, beta_v, @beta_f.seps - beta_u.seps - beta_qu.seps
    yield bipainter.blankets
  end

end end
