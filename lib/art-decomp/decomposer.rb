module ArtDecomp class Decomposer
  def initialize opts
    self.archs = opts.fetch :archs
    self.fsm   = opts.fetch :fsm
    self.uv    = opts.fetch(:gens).fetch :uv
    self.qu    = opts.fetch(:gens).fetch :qu
    self.qv    = opts.fetch(:gens).fetch :qv
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
