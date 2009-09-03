module ArtDecomp class Decomposer

  def initialize params
    @fsm    = params[:fsm]
    @archs  = params[:archs]
    @uv_gen = params[:uv_gens].first.new @fsm, @archs
    @qu_gen = params[:qu_gens].first.new
    @qv_gen = params[:qv_gens].first.new
  end

  def decompositions
    Enumerator.new do |yielder|
      @uv_gen.uv_pairs.each do |fsm, u, v|
        @qu_gen.qu_blankets(fsm, u, v).each do |qu|
          @qv_gen.blankets(fsm, u, v, qu).each do |qv, g|
            yielder.yield Decomposition.new fsm, u, v, qu, qv, g, :uv_gen => @uv_gen.class, :qu_gen => @qu_gen.class, :qv_gen => @qv_gen.class
          end
        end
      end
    end
  end

end end
