module ArtDecomp class Decomposer

  def initialize params
    @fsm    = params[:fsm]
    @archs  = params[:archs]
    @uv_gen = params[:uv_class].new @fsm, @archs
    @qu_gen = params[:qu_class].new
    @qv_gen = params[:qv_class].new
  end

  def decompositions
    Enumerator.new do |yielder|
      @uv_gen.each do |fsm, u, v|
        @qu_gen.each fsm, u, v do |qu|
          @qv_gen.each fsm, u, v, qu do |qv, g|
            yielder.yield Decomposition.new fsm, u, v, qu, qv, g
          end
        end
      end
    end
  end

end end
