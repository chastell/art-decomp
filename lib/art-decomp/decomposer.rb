module ArtDecomp class Decomposer

  def initialize params
    @fsm    = params[:fsm]
    @archs  = params[:archs]
    @uv_gen = params[:uv_gen].new @fsm, @archs
    @qu_gen = params[:qu_gen].new @fsm, @archs
    @qv_gen = params[:qv_gen].new @fsm, @archs
  end

  def each
    @uv_gen.each do |u, v|
      @qu_gen.each u, v do |qu|
        @qv_gen.each u, v, qu do |g, qv|
          yield Decomposition.new @fsm, u, v, qu, g, qv
        end
      end
    end
  end

end end
