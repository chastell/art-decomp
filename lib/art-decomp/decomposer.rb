module ArtDecomp class Decomposer
  def config= config
    self.archs = config.fetch :archs
    self.fsm   = config.fetch :fsm
    self.uv    = config.fetch(:gens).fetch :uv
    self.qu    = config.fetch(:gens).fetch :qu
    self.qv    = config.fetch(:gens).fetch :qv
  end

  def decompositions
    Enumerator.new do |yielder|
      uv.each do |uv_gen|
        uv_gen.uv_pairs(fsm, archs).each do |fsm, u, v|
          qu.each do |qu_gen|
            qu_gen.blankets(fsm, u, v).each do |qu|
              qv.each do |qv_gen|
                qv_gen.blankets(fsm, u, v, qu).each do |qv, g|
                  yielder.yield Decomposition.new fsm, u, v, qu, qv, g
                end
              end
            end
          end
        end
      end
    end
  end

  protected

  attr_accessor :archs, :fsm, :uv, :qu, :qv
end end
