require_relative '../../spec_helper'

module ArtDecomp describe QuGenerators::EdgeLabels do
  describe '#blankets' do
    it 'fist merges until its graph is complete' do
      qu_blankets(
        beta_f: MiniTest::Mock.new.expect(:seps, Set[Sep[1,2], Sep[2,3]]),
        beta_q: Blanket[B[1], B[2], B[3]],
        beta_x: Blanket[],
        generator: QuGenerators::EdgeLabels.new,
      ).first.must_equal Blanket[B[1,3], B[2]]
    end

    it 'then merges blocks based on r-admissibility of the merged block, all the way down' do
      qu_blankets(
        beta_f: Blanket[B[1], B[2,3], B[4], B[5], B[6]],
        beta_q: Blanket[B[1], B[2,3], B[4,5,6]],
        beta_x: Blanket[],
        generator: QuGenerators::EdgeLabels.new,
      ).to_a.must_equal [
        Blanket[B[1], B[2,3], B[4,5,6]],
        Blanket[B[1,2,3], B[4,5,6]],
        Blanket[B[1,2,3,4,5,6]],
      ]
    end

    it 'merges blocks based on the number of separations lost (if the r-admissibility is the same)' do
      qu_blankets(
        beta_f: Blanket[B[1,2], B[3,4,5], B[6]],
        beta_q: Blanket[B[1,2], B[3,4,5], B[6]],
        beta_x: Blanket[],
        generator: QuGenerators::EdgeLabels.new,
      ).to_a.must_equal [
        Blanket[B[1,2], B[3,4,5], B[6]],
        Blanket[B[1,2,6], B[3,4,5]],
        Blanket[B[1,2,3,4,5,6]],
      ]
    end
  end
end end
