require_relative '../../spec_helper'

module ArtDecomp
  describe CoreExtensions::String do
    describe '#dc_expand' do
      it 'expands don’t-cares when representing boolean inputs' do
        '0'.extend(CoreExtensions::String).dc_expand.must_equal   ['0']
        '-'.extend(CoreExtensions::String).dc_expand.must_equal   %w[0 1]
        '-1-'.extend(CoreExtensions::String).dc_expand.must_equal %w[010 011 110 111]
      end

      it 'the expansion is limitable to the given set of columns' do
        '---'.extend(CoreExtensions::String).dc_expand
             .must_equal %w[000 001 010 011 100 101 110 111]
        '---'.extend(CoreExtensions::String).dc_expand(Set[0,2])
             .must_equal ['0-0', '0-1', '1-0', '1-1']
        '---'.extend(CoreExtensions::String).dc_expand(Set[1])
             .must_equal ['-0-', '-1-']
      end
    end
  end
end
