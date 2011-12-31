require_relative '../../spec_helper'

module ArtDecomp describe QvGenerator::GraphColouring do
  describe '#blankets' do
    it 'uses graph colouring of the proper incompatibility graphs' do
      beta_f  = MiniTest::Mock.new.expect :seps, Set[Sep[1,2], Sep[1,3], Sep[1,6], Sep[2,6], Sep[3,4], Sep[3,6], Sep[4,5], Sep[5,6]]
      beta_u  = Blanket[]
      beta_v  = Blanket[B[1,3,5], B[2,4,6]]
      beta_qu = Blanket[]

      fsm = MiniTest::Mock.new
      fsm.expect :beta_f, beta_f
      fsm.expect :beta_q, Blanket[B[1,2], B[3,4], B[5,6]]
      def fsm.beta_x set
        case set
        when Set[0] then Blanket[]
        when Set[1] then Blanket[B[1,3,5], B[2,4,6]]
        end
      end

      blankets = QvGenerator::GraphColouring.new.blankets(fsm, Set[0], Set[1], beta_qu).to_a

      blankets.size.must_equal 2
      blankets.first.must_equal [Blanket[B[1,2], B[3,4], B[5,6]], Blanket[B[1,5], B[2,3], B[4,6]]]
      blankets.last.must_equal [Blanket[B[1,2], B[3,4,5,6]], Blanket[B[1], B[2,3,5], B[4,6]]]
      blankets.each do |beta_qv, beta_g|
        assert beta_f.seps.subset? beta_u.seps + beta_qu.seps + beta_g.seps
        assert beta_g.seps.subset? beta_v.seps + beta_qv.seps
      end
    end
  end
end end
