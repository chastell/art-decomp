module ArtDecomp class QvGenerator::Bipainting < QvGenerator

  def each u, v, beta_qu
    beta_u = @fsm.beta_x u
    beta_v = @fsm.beta_x v
    bipainter = Bipainter.new @beta_q, beta_v, @beta_f.seps - beta_u.seps - beta_qu.seps
    yield bipainter.blankets
  end

end end
