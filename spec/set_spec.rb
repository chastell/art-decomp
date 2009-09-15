# encoding: UTF-8

describe Set do

  include ArtDecomp

  it 'should side-step a MRI bug with Set#hash' do
    Set[2305860601668175887].hash.should == Set[2305860601668175887].hash
  end

  context 'of Separations' do

    it 'should provide a given block’s r-admissibility' do
      b = B[1,2,3,4]
      Set[Sep[1,5]].r_adm(b).should == 0
      Set[Sep[1,4]].r_adm(b).should == 1
      Set[Sep[1,2], Sep[5,6]].r_adm(b).should == 1
      Set[Sep[1,2], Sep[3,4]].r_adm(b).should == 1
      Set[Sep[1,3], Sep[1,4], Sep[2,3], Sep[2,4]].r_adm(b).should == 1
      Set[Sep[1,3], Sep[1,4], Sep[2,3], Sep[2,4], Sep[3,4]].r_adm(b).should == 2
      Blanket[B[1],B[2],B[3],B[4]].seps.r_adm(b).should == 2
    end

  end

end
