module ArtDecomp class Decomposer

  def initialize params
    @archs   = params[:archs]
    @uv_gens = params[:uv_gens].map { |gen| gen.new params[:fsm], params[:archs] }
    @qu_gens = params[:qu_gens].map(&:new)
    @qv_gens = params[:qv_gens].map(&:new)
  end

  def decompositions opts = {}
    @seen = Set[]
    Enumerator.new do |yielder|
      @uv_gens.each do |uv_gen|
        uv_gen.uv_pairs.each do |fsm, u, v|
          unless @seen.include? [fsm, u, v]
            @qu_gens.each do |qu_gen|
              qu_gen.blankets(fsm, u, v).each do |qu|
                unless @seen.include? [fsm, u, v, qu]
                  @qv_gens.each do |qv_gen|
                    qv_gen.blankets(fsm, u, v, qu).each do |qv, g|
                      unless @seen.include? [fsm, u, v, qu, qv, g]
                        dec = Decomposition.new fsm, u, v, qu, qv, g
                        if dec.sensible? @archs
                          if opts[:non_disjoint]
                            non_disjoint(fsm, u, v, qu, qv, g).each do |ndj|
                              yielder.yield ndj
                            end
                          else
                            yielder.yield dec
                          end
                        end
                        @seen << [fsm, u, v, qu, qv, g] unless opts[:keep_seen]
                      end
                    end
                  end
                  @seen << [fsm, u, v, qu] unless opts[:keep_seen]
                end
              end
            end
            @seen << [fsm, u, v] unless opts[:keep_seen]
          end
        end
      end
    end
  end

  private

  def non_disjoint fsm, u_dj, v, qu, qv_dj, g_dj
    Enumerator.new do |yielder|
      (v - u_dj).each do |v_input|
        u = u_dj + [v_input]
        unless @seen.include? [fsm, u, v, qu]
          @qv_gens.each do |qv_gen|
            qv_gen.blankets(fsm, u, v, qu).each do |qv, g|
              unless @seen.include? [fsm, u, v, qu, qv, g]
                dec = Decomposition.new fsm, u, v, qu, qv, g
                if dec.sensible? @archs and g.pins < g_dj.pins
                  non_disjoint(fsm, u, v, qu, qv, g).each do |ndj|
                    yielder.yield ndj
                  end
                end
                @seen << [fsm, u, v, qu, qv, g]
              end
            end
          end
          @seen << [fsm, u, v, qu]
        end
      end
      yielder.yield Decomposition.new fsm, u_dj, v, qu, qv_dj, g_dj
    end
  end

end end
