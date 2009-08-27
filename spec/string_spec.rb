describe String do

  it 'should provide an expansion of don’t-cares when representing boolean inputs' do
    '0'.dc_expand.should   == ['0']
    '-'.dc_expand.should   == ['0', '1']
    '-1-'.dc_expand.should == ['010', '011', '110', '111']
  end

  it 'the expansion should be limitable to just a given set of columns' do
    '---'.dc_expand.should == ['000', '001', '010', '011', '100', '101', '110', '111']
    '---'.dc_expand([0,2]).should == ['0-0', '0-1', '1-0', '1-1']
  end

end
