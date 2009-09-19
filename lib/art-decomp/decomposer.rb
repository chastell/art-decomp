module ArtDecomp class Decomposer

  def initialize params
    @archs   = params[:archs]
    @uv_gens = params[:uv_gens].map { |gen| gen.new params[:fsm], params[:archs] }
    @qu_gens = params[:qu_gens].map(&:new)
    @qv_gens = params[:qv_gens].map(&:new)
  end

  def decompositions skip_seen = true
    seen = {}
    Enumerator.new do |yielder|
      @uv_gens.each do |uv_gen|
        uv_gen.uv_pairs.each do |fsm, u, v|
          unless seen[[fsm, u, v]]
            @qu_gens.each do |qu_gen|
              qu_gen.blankets(fsm, u, v).each do |qu|
                unless seen[[fsm, u, v, qu]]
                  @qv_gens.each do |qv_gen|
                    qv_gen.blankets(fsm, u, v, qu).each do |qv, g|
                      unless seen[[fsm, u, v, qu, qv, g]]
                        dec = Decomposition.new fsm, u, v, qu, qv, g, :uv_gen => uv_gen.class, :qu_gen => qu_gen.class, :qv_gen => qv_gen.class
                        yielder.yield dec if dec.sensible? @archs
                        seen[[fsm, u, v, qu, qv, g]] = true if skip_seen
                      end
                    end
                  end
                  seen[[fsm, u, v, qu]] = true if skip_seen
                end
              end
            end
            seen[[fsm, u, v]] = true if skip_seen
          end
        end
      end
    end
  end

end end
