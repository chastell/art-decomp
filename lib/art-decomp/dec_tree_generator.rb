module ArtDecomp class DecTreeGenerator
  def initialize opts
    self.archs                = opts.fetch :archs
    self.fsm                  = opts.fetch :fsm
    self.gens                 = opts.fetch :gens
    self.decomposer_generator = opts.fetch :decomposer_generator
  end

  def dectrees fsm = fsm, dec_tree = DecTree.new
    Enumerator.new do |yielder|
      decomposer = decomposer_generator.new fsm: fsm, archs: archs, gens: gens
      decomposer.decompositions.each do |dec|
        dec_tree << dec
        if dec.final? archs
          yielder.yield dec_tree.dup
        else
          dectrees(dec.h, dec_tree).each { |subtree| yielder.yield subtree }
        end
        dec_tree.pop
      end
    end
  end

  protected

  attr_accessor :archs, :decomposer_generator, :fsm, :gens
end end
