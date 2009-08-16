module ArtDecomp class QvGenerator

  def initialize fsm, archs
    @fsm, @beta_f, @beta_q = fsm, fsm.beta_f, fsm.beta_q
  end

end end
