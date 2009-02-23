module ArtDecomp class Decomposer

  def initialize params
    @fsm    = params[:fsm]
    @archs  = params[:archs]
    @uv_gen = params[:uv_gen].new @fsm, @archs.map{|a| a.pins}.max
  end

end end
