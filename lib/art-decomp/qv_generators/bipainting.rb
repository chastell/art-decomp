module ArtDecomp module QvGenerators class Bipainting
  def blankets fsm, u, v, beta_qu
    beta_u    = fsm.beta_x u
    beta_v    = fsm.beta_x v
    bipainter = Bipainter.new fsm.beta_q, beta_v, fsm.beta_f.seps - beta_u.seps - beta_qu.seps
    Enumerator.new do |yielder|
      yielder.yield bipainter.blankets
    end
  end
end end end
