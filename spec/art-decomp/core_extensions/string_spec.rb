# encoding: UTF-8

module ArtDecomp describe CoreExtensions::String do

  describe '#dc_expand' do

    it 'expands don’t-cares when representing boolean inputs' do
      '0'.dc_expand.should   == ['0']
      '-'.dc_expand.should   == ['0', '1']
      '-1-'.dc_expand.should == ['010', '011', '110', '111']
    end

    it 'the expansion is limitable to the given set of columns' do
      '---'.dc_expand.should           == ['000', '001', '010', '011', '100', '101', '110', '111']
      '---'.dc_expand(Set[0,2]).should == ['0-0', '0-1', '1-0', '1-1']
      '---'.dc_expand(Set[1]).should   == ['-0-', '-1-']
    end

  end

end end
