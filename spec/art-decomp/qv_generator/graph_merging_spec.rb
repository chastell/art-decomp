module ArtDecomp describe QvGenerator::GraphMerging do

  context 'when generating G and Qv blankets' do

    it 'should merge vertices of the proper incompatibility graphs' do
      beta_f  = mock 'Blanket', :seps => Set[Sep[1,2], Sep[1,3], Sep[1,6], Sep[2,6], Sep[3,4], Sep[3,6], Sep[4,5], Sep[5,6]]
      beta_q  = Blanket[B[1,2], B[3,4], B[5,6]]
      beta_u  = Blanket[]
      beta_v  = Blanket[B[1,3,5], B[2,4,6]]
      beta_qu = Blanket[]

      fsm = mock 'FSM', :beta_f => beta_f, :beta_q => beta_q
      fsm.should_receive(:beta_x).with([0]).and_return beta_u
      fsm.should_receive(:beta_x).with([1]).and_return beta_v
      archs = Set[Arch[3,1]]
      gm = QvGenerator::GraphMerging.new

      pairs = gm.blankets(fsm, [0], [1], beta_qu).to_a
      pairs.first.should == [Blanket[B[1,2], B[3,4], B[5,6]], Blanket[B[1,5], B[2,3], B[4,6]]]
      pairs.last.should  == [Blanket[B[1,2], B[3,4,5,6]],     Blanket[B[1], B[2,3,5], B[4,6]]]

      pairs.each do |beta_qv, beta_g|
        beta_f.seps.should be_subset(beta_u.seps + beta_qu.seps + beta_g.seps)
        beta_g.seps.should be_subset(beta_v.seps + beta_qv.seps)
      end
    end

  end

end end
