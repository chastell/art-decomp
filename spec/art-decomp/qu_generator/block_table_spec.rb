# encoding: UTF-8

require_relative '../../spec_helper'

module ArtDecomp describe QuGenerator::BlockTable do
  describe '#blankets' do
    def blankets beta_f, beta_q, beta_x
      fsm = MiniTest::Mock.new
      fsm.expect :beta_f, beta_f
      fsm.expect :beta_q, beta_q
      fsm.expect :beta_x, beta_x, [Array]
      QuGenerator::BlockTable.new.blankets fsm, Set[0], Set[1]
    end

    it 'folds Q blocks that match in the first go' do
      beta_f = Blanket[]
      beta_q = Blanket[B[1,2], B[2], B[3]]
      beta_x = Blanket[B[1], B[2], B[3]]
      blankets(beta_f, beta_q, beta_x).first.must_equal Blanket[B[1,2,3], B[2]]
    end

    it 'doesn’t fold Q blocks if they don’t match' do
      beta_f = Blanket[]
      beta_q = Blanket[B[1,2], B[2,3]]
      beta_x = Blanket[B[1], B[2], B[3]]
      blankets(beta_f, beta_q, beta_x).first.must_equal Blanket[B[1,2], B[2,3]]
    end

    it 'first tries to fold matching blocks and then folds by r-admissibility' do
      beta_f = MiniTest::Mock.new.expect :seps, Set[Sep[1,2], Sep[2,3]]
      beta_q = Blanket[B[1], B[2], B[3]]
      beta_x = Blanket[B[1,2,3], B[1,3]]
      blankets(beta_f, beta_q, beta_x).to_a.must_equal [
        Blanket[B[1], B[2], B[3]],
        Blanket[B[1,3], B[2]],
        Blanket[B[1,2,3]],
      ]
    end
  end
end end
