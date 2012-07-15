module ArtDecomp class DecTreeGenerator
  def initialize opts
    self.archs                = opts.fetch :archs
    self.fsm                  = opts.fetch :fsm
    self.gens                 = opts.fetch :gens
    self.decomposer_generator = opts.fetch :decomposer_generator
  end

  def dectrees opts = {}
    this_fsm = opts.fetch :fsm, fsm
    dec_tree = opts.fetch :dec_tree, DecTree.new
    Enumerator.new do |yielder|
      decomposer = decomposer_generator.new fsm: this_fsm, archs: archs, gens: gens
      decomposer.decompositions.each do |dec|
        dec_tree << dec
        if dec.final? archs
          yielder.yield dec_tree.dup
        else
          dectrees(fsm: dec.h, dec_tree: dec_tree).each do |subtree|
            yielder.yield subtree
          end
        end
        dec_tree.pop
      end
    end
  end

  protected

  attr_accessor :archs, :decomposer_generator, :fsm, :gens
end end
