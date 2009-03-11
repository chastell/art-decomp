describe Set, 'of Separations' do

  it 'should provide a given block’s r-admissibility' do
    b = B[1,2,3,4]
    Set[Sep[1,5]].r_adm(b).should == 0
    Set[Sep[1,4]].r_adm(b).should == 1
    Set[Sep[1,2], Sep[5,6]].r_adm(b).should == 1
    Set[Sep[1,2], Sep[3,4]].r_adm(b).should == 1
    Set[Sep[1,3], Sep[1,4], Sep[2,3], Sep[2,4]].r_adm(b).should == 1
    Set[Sep[9,11], Sep[8,13], Sep[7,13], Sep[10,12], Sep[13,17], Sep[8,17], Sep[10,16]].r_adm(B[7,8,9,10,11,12,13,16,17]).should == 2
  end

end
