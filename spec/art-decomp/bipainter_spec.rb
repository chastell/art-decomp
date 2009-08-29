module ArtDecomp describe Bipainter do

  context 'when used for generating the Qv and G blankets' do

    # FIXME: add more specs, targeting non-trivial cases

    it 'should colour the two incompatibility graphs properly and return the resulting blankets' do
      beta_q = Blanket[B[1,2], B[3,4], B[5,6]]
      beta_v = Blanket[B[1,3,5], B[2,4,6]]
      seps   = Set[Sep[1,2], Sep[1,3], Sep[1,6], Sep[2,6], Sep[3,4], Sep[3,6], Sep[4,5], Sep[5,6]]

      bipainter = Bipainter.new beta_q, beta_v, seps
      bipainter.blankets.should == [Blanket[B[1,2], B[3,4,5,6]], Blanket[B[1], B[2,3,5], B[4,6]]]
    end

  end

end end
