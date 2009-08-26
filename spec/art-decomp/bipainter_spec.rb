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

    it '…' do
      beta_q = Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]]
      beta_v = Blanket[B[0,3,5,6,7,9], B[1,2,3,4,6,8,9,10]]
      seps   = Set[Sep[0,2], Sep[4,5], Sep[7,8]]

      bipainter = Bipainter.new beta_q, beta_v, seps
      bipainter.blankets.should == [Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]],  Blanket[B[0,3,5,6,7,9,10], B[1,2,3,4,6,8]]]
    end

    it '…' do
      beta_q = Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]]
      beta_v = Blanket[B[0,3,5,6,7,9], B[1,2,3,4,6,8,9,10]]
      seps   = Set[Sep[0,2], Sep[0,3], Sep[0,5], Sep[1,5], Sep[4,5], Sep[7,8], Sep[7,9]]

      bipainter = Bipainter.new beta_q, beta_v, seps
      bipainter.blankets.should == [Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]], Blanket[B[0,6,7], B[1,2,3,4], B[3,5,6,8,9,10]]]
    end

    it '…' do
      beta_q = Blanket[B[0,1,2], B[3,4,5], B[6,7,8], B[9,10]]
      beta_v = Blanket[B[0,3,7,9], B[0,5,6], B[1,4,6,10], B[2,3,8,9]]
      seps   = Set[Sep[0,2], Sep[1,2], Sep[3,4], Sep[3,5], Sep[4,5], Sep[6,7], Sep[6,8], Sep[7,8], Sep[9,10]]

      bipainter = Bipainter.new beta_q, beta_v, seps
      bipainter.blankets.should == [Blanket[B[0,1,2], B[3,4,5,9,10], B[6,7,8]], Blanket[B[0,1,3,6,9], B[2,4,8,10], B[5,7]]]
    end

    it '…fsm…' do
      pending
      beta_q = Blanket[B[0], B[1,2], B[3], B[4,5], B[6,7,8,9,10,11,12], B[13,14], B[15,16], B[17], B[18], B[19]]
      beta_v = Blanket[B[0,1,6,19], B[0,7,9,15], B[2,3,12], B[2,4,10,12,14], B[2,4,12], B[2,8,12,13,18], B[5,6,17], B[5,7,11,16]]
      seps   = Set[Sep[0,2], Sep[0,3], Sep[0,4], Sep[0,5], Sep[1,2], Sep[1,3], Sep[1,4], Sep[1,5], Sep[2,3], Sep[2,4], Sep[2,5], Sep[3,5], Sep[4,5], Sep[6,7], Sep[6,12], Sep[7,12], Sep[8,9], Sep[8,10], Sep[8,11], Sep[9,10], Sep[9,11], Sep[10,11], Sep[13,16], Sep[14,15], Sep[17,18]]
      bipainter = Bipainter.new beta_q, beta_v, seps
      bipainter.blankets#.should == [Blanket[B[0,1,2], B[3,4,5,9,10], B[6,7,8]], Blanket[B[0,1,3,6,9], B[2,4,8,10], B[5,7]]]
    end

  end

end end
