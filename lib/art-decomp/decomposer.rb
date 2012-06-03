module ArtDecomp class Decomposer
  def initialize params
    @archs   = params[:archs]
    @fsm     = params[:fsm]
    @uv_gens = params[:uv_gens].map(&:new)
    @qu_gens = params[:qu_gens].map(&:new)
    @qv_gens = params[:qv_gens].map(&:new)
  end

  def decompositions opts = {}
    tabs = "\t" * opts.fetch(:level, 0)
    Log.info "#{tabs}FSM #{@fsm.stats}"
    Enumerator.new do |yielder|
      @uv_gens.each do |uv_gen|
        Log.info "#{tabs}\tUV #{uv_gen.class}"
        uv_gen.uv_pairs(@fsm, @archs).each do |fsm, u, v|
          Log.info "#{tabs}\t\t#{u.sort.join ' '} | #{v.sort.join ' '}"
          @qu_gens.each do |qu_gen|
            qu_gen.blankets(fsm, u, v).each do |qu|
              @qv_gens.each do |qv_gen|
                qv_gen.blankets(fsm, u, v, qu).each do |qv, g|
                  dec = Decomposition.new fsm, u, v, qu, qv, g
                  if dec.sensible? @archs
                    yielder.yield dec
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end end
