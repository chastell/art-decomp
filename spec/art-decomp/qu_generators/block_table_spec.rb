require_relative '../../spec_helper'

module ArtDecomp
  describe QuGenerators::BlockTable do
  describe '#==' do
    it 'performs class-based comparison' do
      QuGenerators::BlockTable.new.must_equal QuGenerators::BlockTable.new
    end
  end

  describe '#blankets' do
    it 'folds Q blocks that match in the first go' do
      qu_blankets(
        beta_f: Blanket[],
        beta_q: Blanket[B[1,2], B[2], B[3]],
        beta_x: Blanket[B[1], B[2], B[3]],
        generator: QuGenerators::BlockTable.new,
      ).first.must_equal Blanket[B[1,2,3], B[2]]
    end

    it 'doesn’t fold Q blocks if they don’t match' do
      qu_blankets(
        beta_f: Blanket[],
        beta_q: Blanket[B[1,2], B[2,3]],
        beta_x: Blanket[B[1], B[2], B[3]],
        generator: QuGenerators::BlockTable.new,
      ).first.must_equal Blanket[B[1,2], B[2,3]]
    end

    it 'first tries to fold matching blocks and then folds by r-admissibility' do
      qu_blankets(
        beta_f: MiniTest::Mock.new.expect(:seps, Set[Sep[1,2], Sep[2,3]]),
        beta_q: Blanket[B[1], B[2], B[3]],
        beta_x: Blanket[B[1,2,3], B[1,3]],
        generator: QuGenerators::BlockTable.new,
      ).to_a.must_equal [
        Blanket[B[1], B[2], B[3]],
        Blanket[B[1,3], B[2]],
        Blanket[B[1,2,3]],
      ]
    end
  end
  end end
