describe QvGenerator::BlockGraph do

  context 'when generating G and Qv blankets' do

    it 'should use graph colouring of the proper incompatibility graphs' do
      beta_f  = Blanket[B[1,2], B[3], B[4,5], B[6,7,19,20], B[8], B[9,15], B[10], B[11,14], B[12,16], B[13], B[17], B[18]]
      beta_q  = Blanket[B[1], B[2,3], B[4], B[5,6], B[7,8,9,10,11,12,13], B[14,15], B[16,17], B[18], B[19], B[20]]
      beta_u  = Blanket[B[1,2,3,5,6,9,11,15,20], B[1,3,4,5,6,10,12,16], B[1,3,4,6,8,13,17], B[1,3,6,7,13,14,18,19]]
      beta_v  = Blanket[B[1,2,7,8,10,16,20], B[3,4,9,13,14,19], B[3,5,11,13,15], B[6,7,8,12,17,18]]
      beta_qu = Blanket[B[1,14,15,16,17], B[2,3,4,18], B[5,6,19,20], B[7,8,9,10,11,12,13]]
      fsm = mock 'FSM', :beta_f => beta_f, :beta_q => beta_q
      fsm.should_receive(:beta_x).with([0]).and_return beta_u
      fsm.should_receive(:beta_x).with([1]).and_return beta_v
      archs = Set[Arch[3,1]]
      gb = QvGenerator::BlockGraph.new fsm, archs

      beta_qv, beta_g = nil, nil
      gb.each([0], [1], beta_qu) { |qv, g| beta_qv, beta_g = qv, g }
      beta_qv.size.should == 3
      beta_g.size.should  == 4

      beta_f.seps.should be_subset(beta_u.seps + beta_qu.seps + beta_g.seps)
      beta_g.seps.should be_subset(beta_v.seps + beta_qv.seps)
    end

  end

end
