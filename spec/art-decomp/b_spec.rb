require_relative '../spec_helper'

module ArtDecomp
  describe B do
    describe '.[]' do
      it 'constructs an Integer with the given bits set' do
        B[].must_equal     0b0
        B[0].must_equal    0b1
        B[5,8].must_equal  0b100100000
        B[30].must_equal   2**30
        B[40].must_equal   2**40
        B[1,69].must_equal 2**69 + 0b10
      end
    end

    describe '#hash' do
      it 'hashes uniformly' do
        b_30_int   = 2**30
        b_40_int   = 2**40
        b_1_69_int = 2**69 + 0b10
        B[].hash.must_equal     0b0.hash
        B[0].hash.must_equal    0b1.hash
        B[5,8].hash.must_equal  0b100100000.hash
        B[30].hash.must_equal   b_30_int.hash
        B[40].hash.must_equal   b_40_int.hash
        B[1,69].hash.must_equal b_1_69_int.hash
      end
    end
  end end
