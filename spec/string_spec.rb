describe String do

  it 'should provide an expansion of don’t-cares when representing boolean inputs' do
    '0'.dc_expand.should   == ['0']
    '-'.dc_expand.should   == ['0', '1']
    '-1-'.dc_expand.should == ['010', '011', '110', '111']
  end

end
