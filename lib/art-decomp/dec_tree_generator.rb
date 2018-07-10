module ArtDecomp
  class DecTreeGenerator
    def initialize(opts)
      self.archs            = opts.fetch :archs
      self.fsm              = opts.fetch :fsm
      self.gens             = opts.fetch :gens
      self.decomposer_class = opts.fetch :decomposer_class, Decomposer
    end

    def dectrees(fsm = self.fsm, dec_tree = DecTree.new(archs)) # rubocop:disable MethodLength
      Enumerator.new do |yielder|
        decomposer = decomposer_class.new fsm: fsm, archs: archs, gens: gens
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

    attr_accessor :archs, :decomposer_class, :fsm, :gens
  end
end
