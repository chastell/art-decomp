module ArtDecomp class DecTreeGenerator
  def initialize opts
    @archs            = opts.fetch :archs
    @best_cells       = Infinity
    @best_slices      = Infinity
    @fsm              = opts.fetch :fsm
    @gens             = opts.fetch :gens
    @decomposer_class = opts.fetch :decomposer_class, Decomposer
  end

  def dectrees fsm = fsm, dec_tree = DecTree.new(archs)
    Enumerator.new do |yielder|
      decomposer = decomposer_class.new fsm: fsm, archs: archs, gens: gens
      decomposer.decompositions.each do |dec|
        dec_tree << dec
        # if dec_tree.slices <= @best_slices
        #   @best_slices = dec_tree.slices
        # elsif dec_tree.slices < Infinity
        #   dec_tree.pop
        #   next
        # end
        if dec.final? archs
          if dec_tree.slices < @best_slices or (dec_tree.slices == @best_slices and dec_tree.cells < @best_cells)
            @best_slices = dec_tree.slices
            @best_cells  = dec_tree.cells
            puts "#{dec_tree.slices} slices, #{dec_tree.cells} cells: #{dec_tree.send :g_archs} #{dec_tree.send :h_arch}"
            yielder.yield dec_tree.dup
          else
            dec_tree.pop
            next
          end
        else
          dectrees(dec.h, dec_tree).each { |subtree| yielder.yield subtree }
        end
        dec_tree.pop
      end
    end
  end

  protected

  attr_accessor :archs, :decomposer_class, :fsm, :gens
end end
