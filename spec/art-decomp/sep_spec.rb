require_relative '../spec_helper'

module ArtDecomp
  describe Sep do
  describe '.[]' do
    it 'constructs an Integer with set bits representing the separation' do
      Sep[1,2].must_equal  0b110
      Sep[0,69].must_equal 2**69 + 0b1
    end
  end

  describe '#hash' do
    it 'hashes uniformly' do
      sep_0_69_int = 2**69 + 0b1
      Sep[1,2].hash.must_equal  0b110.hash
      Sep[0,69].hash.must_equal sep_0_69_int.hash
    end
  end
  end end
