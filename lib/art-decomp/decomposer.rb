module ArtDecomp class Decomposer

  def initialize params
    @fsm    = params[:fsm]
    @archs  = params[:archs]
    @uv_gen = params[:uv_gen].new @fsm, @archs
    @qu_gen = params[:qu_gen].new @fsm, @archs
    @qv_gen = params[:qv_gen].new @fsm, @archs
  end

end end
