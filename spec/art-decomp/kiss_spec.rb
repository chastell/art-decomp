require_relative '../spec_helper'

module ArtDecomp describe KISS do

  describe '#formatted' do

    it 'sorts entries' do
      kiss = KISS.new ['1 1', '0 0']
      kiss.formatted.must_equal "0 0\n1 1\n"
    end

    it 'drops non-unique entries' do
      kiss = KISS.new ['0 0', '0 0']
      kiss.formatted.must_equal "0 0\n"
    end

    it 'drops overlapping entries' do
      kiss = KISS.new ['0-0 0', '010 0', '1-1 1', '--1 1']
      kiss.formatted.must_equal "--1 1\n0-0 0\n"
    end

    it 'preserves overlapping entries differing on subsequent column groups' do
      kiss = KISS.new ['-- 1 0 1', '10 0 0 1']
      kiss.formatted.must_equal "-- 1 0 1\n10 0 0 1\n"
    end

    it 'combines matching entries' do
      kiss = KISS.new ['00 0 1 1', '01 0 1 1', '10 1 0 0', '11 1 0 0']
      kiss.formatted.must_equal "0- 0 1 1\n1- 1 0 0\n"
      kiss = KISS.new ['00 0', '11 0', '10 0', '01 0']
      kiss.formatted.must_equal "-- 0\n"
    end

  end

end end
