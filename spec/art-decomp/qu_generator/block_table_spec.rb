# encoding: UTF-8

module ArtDecomp describe QuGenerator::BlockTable do

  context '#blankets' do

    def qus
      fsm   = mock FSM, beta_f: @beta_f, beta_q: @beta_q, beta_x: @beta_x
      archs = Set[Arch[3,1]]
      bt    = QuGenerator::BlockTable.new
      bt.blankets(fsm, Set[0], Set[1]).to_a
    end

    it 'folds Q blocks that match in the first go' do
      @beta_f = Blanket[]
      @beta_q = Blanket[B[1,2], B[2], B[3]]
      @beta_x = Blanket[B[1], B[2], B[3]]
      qus.first.should == Blanket[B[1,2,3], B[2]]
    end

    it 'doesn’t fold Q blocks if they don’t match' do
      @beta_f = Blanket[]
      @beta_q = Blanket[B[1,2], B[2,3]]
      @beta_x = Blanket[B[1], B[2], B[3]]
      qus.first.should == Blanket[B[1,2], B[2,3]]
    end

    it 'first tries to fold matching blocks and then folds by r-admissibility' do
      @beta_f = mock Blanket, :seps => Set[Sep[1,2], Sep[2,3]]
      @beta_q = Blanket[B[1], B[2], B[3]]
      @beta_x = Blanket[B[1,2,3], B[1,3]]
      qus.should == [Blanket[B[1], B[2], B[3]], Blanket[B[1,3], B[2]], Blanket[B[1,2,3]]]
    end

  end

end end
