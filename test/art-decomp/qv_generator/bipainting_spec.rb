require_relative '../../spec_helper'

module ArtDecomp describe QvGenerator::Bipainting do

  describe '#blankets' do

    it 'uses graph bicolouring' do
      beta_f  = MiniTest::Mock.new
      beta_f.expect :seps, Set[Sep[1,2], Sep[1,3], Sep[1,6], Sep[2,6], Sep[3,4], Sep[3,6], Sep[4,5], Sep[5,6]]
      beta_q  = Blanket[B[1,2], B[3,4], B[5,6]]
      beta_u  = Blanket[]
      beta_v  = Blanket[B[1,3,5], B[2,4,6]]
      beta_qu = Blanket[]

      fsm = Object.new
      fsm.define_singleton_method(:beta_f) { beta_f }
      fsm.define_singleton_method(:beta_q) { beta_q }
      fsm.define_singleton_method(:beta_x) { |set| case set; when Set[0] then beta_u; when Set[1] then beta_v; end }
      archs = Set[Arch[3,1]]
      bi = QvGenerator::Bipainting.new

      beta_qv, beta_g = bi.blankets(fsm, Set[0], Set[1], beta_qu).to_a.first
      beta_qv.must_equal Blanket[B[1,2], B[3,4,5,6]]
      beta_g.must_equal  Blanket[B[1], B[2,3,5], B[4,6]]

      assert beta_f.seps.subset?(beta_u.seps + beta_qu.seps + beta_g.seps)
      assert beta_g.seps.subset?(beta_v.seps + beta_qv.seps)
    end

  end

end end
