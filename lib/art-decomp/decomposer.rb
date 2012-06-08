module ArtDecomp class Decomposer
  def initialize params
    @archs   = params[:archs]
    @fsm     = params[:fsm]
    @uv_gens = params[:uv_gens].map(&:new)
    @qu_gens = params[:qu_gens].map(&:new)
    @qv_gens = params[:qv_gens].map(&:new)
  end

  def decompositions opts = {}
    tabs = "  " * opts.fetch(:level, 0)
    Log.warn "#{tabs}FSM #{@fsm.stats}" if defined? Log
    Enumerator.new do |yielder|
      @uv_gens.each do |uv_gen|
        uv_gen.uv_pairs(@fsm, @archs).each do |fsm, u, v|
          Log.warn "#{tabs}  #{u.sort.join ' '} | #{v.sort.join ' '} with #{uv_gen.class}" if defined? Log
          @qu_gens.each do |qu_gen|
            qu_gen.blankets(fsm, u, v).each do |qu|
              Log.info "#{tabs}    #{qu.pins} Qu pins with #{qu_gen.class}" if defined? Log
              @qv_gens.each do |qv_gen|
                qv_gen.blankets(fsm, u, v, qu).each do |qv, g|
                  Log.debug "#{tabs}      #{qv.pins} Qv pins and #{g.pins} G pins with #{qv_gen.class}" if defined? Log
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
