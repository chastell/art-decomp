module ArtDecomp describe QuGenerator::EdgeLabels do

  context '#blankets' do

    def qus
      fsm   = mock FSM, beta_f: @beta_f, beta_q: @beta_q, beta_x: @beta_x
      archs = Set[Arch[3,1]]
      el    = QuGenerator::EdgeLabels.new
      el.blankets(fsm, Set[0], Set[1]).to_a
    end

    it 'fist merges until its graph is complete' do
      @beta_f = mock Blanket, seps: Set[Sep[1,2], Sep[2,3]]
      @beta_q = Blanket[B[1], B[2], B[3]]
      @beta_x = Blanket[]
      qus.first.should == Blanket[B[1,3], B[2]]
    end

    it 'then merges blocks based on r-admissibility of the merged block, all the way down' do
      @beta_f = Blanket[B[1], B[2,3], B[4], B[5], B[6]]
      @beta_q = Blanket[B[1], B[2,3], B[4,5,6]]
      @beta_x = Blanket[]
      qus.should == [Blanket[B[1], B[2,3], B[4,5,6]], Blanket[B[1,2,3], B[4,5,6]], Blanket[B[1,2,3,4,5,6]]]
    end

    it 'merges blocks based on the number of separations lost (if the r-admissibility is the same)' do
      @beta_f = Blanket[B[1,2], B[3,4,5], B[6]]
      @beta_q = Blanket[B[1,2], B[3,4,5], B[6]]
      @beta_x = Blanket[]
      qus.should == [Blanket[B[1,2], B[3,4,5], B[6]], Blanket[B[1,2,6], B[3,4,5]], Blanket[B[1,2,3,4,5,6]]]
    end

  end

end end
