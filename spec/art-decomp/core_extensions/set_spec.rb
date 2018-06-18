require_relative '../../spec_helper'

module ArtDecomp
  describe CoreExtensions::Set do
  describe '#hash' do
    it 'doesn’t exibit a MRI bug (fixed in r22308)' do
      Set[2_305_860_601_668_175_887].hash.must_equal Set[2_305_860_601_668_175_887].hash
    end
  end

  describe '#r_adm' do
    it 'returns the given block’s r-admissibility' do
      b = B[1,2,3,4]
      Set[Sep[1,5]].r_adm(b).must_equal 0
      Set[Sep[1,4]].r_adm(b).must_equal 1
      Set[Sep[1,2], Sep[5,6]].r_adm(b).must_equal 1
      Set[Sep[1,2], Sep[3,4]].r_adm(b).must_equal 1
      Set[Sep[1,3], Sep[1,4], Sep[2,3], Sep[2,4]].r_adm(b).must_equal 1
      Set[Sep[1,3], Sep[1,4], Sep[2,3], Sep[2,4], Sep[3,4]].r_adm(b).must_equal 2
      ArtDecomp::Blanket[B[1],B[2],B[3],B[4]].seps.r_adm(b).must_equal 2
    end
  end
  end end
