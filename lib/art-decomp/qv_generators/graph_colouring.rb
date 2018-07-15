module ArtDecomp
  module QvGenerators
    class GraphColouring
      def ==(other)
        self.class == other.class
      end

      def blankets(fsm, u, v, beta_qu) # rubocop:disable AbcSize
        beta_u = fsm.beta_x u
        beta_v = fsm.beta_x v
        Enumerator.new do |yielder|
          beta_g  = Graph.new(fsm.beta_q * beta_v, fsm.beta_f.seps - beta_u.seps - beta_qu.seps).blanket_from_colouring
          beta_qv = Graph.new(fsm.beta_q, beta_g.seps - beta_v.seps).blanket_from_colouring
          yielder.yield beta_qv, beta_g
          beta_qv = Graph.new(fsm.beta_q, fsm.beta_f.seps - beta_u.seps - beta_qu.seps - beta_v.seps).blanket_from_colouring
          beta_g  = Graph.new(beta_qv * beta_v, fsm.beta_f.seps - beta_u.seps - beta_qu.seps).blanket_from_colouring
          yielder.yield beta_qv, beta_g
        end
      end
    end
  end
end
