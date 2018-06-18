require_relative '../spec_helper'

module ArtDecomp
  describe Arch do
  describe '.[]' do
    it 'instantiates Arch Array-style' do
      Arch[5,1].must_equal Arch.new 5, 1
    end
  end

  describe '#==' do
    it 'compares I/O counts' do
      Arch[5,1].must_equal Arch[5,1]
      Arch[5,2].wont_equal Arch[5,1]
      Arch[4,1].wont_equal Arch[5,1]
    end
  end

  describe '#<=>' do
    it 'allows sorting' do
      [Arch[5,1], Arch[4,1], Arch[4,2]].sort.must_equal [Arch[5,1], Arch[4,2], Arch[4,1]]
    end
  end

  describe '#cells' do
    it 'reports how many cells of the given Archs it requires' do
      Arch[4,3].cells(Set[Arch[4,2], Arch[5,1]]).must_equal 2
      Arch[4,3].cells(Set[Arch[5,1]]).must_equal 3
      Arch[5,3].cells(Set[Arch[4,3]]).must_equal Infinity
      Arch[5,3].cells(Set[Arch[5,2]]).must_equal 2
    end
  end

  describe '#eql?' do
    it 'compares I/O counts' do
      assert Arch[5,1].eql? Arch[5,1]
      refute Arch[5,2].eql? Arch[5,1]
      refute Arch[4,1].eql? Arch[5,1]
    end
  end

  describe '#hash' do
    it 'is I/O-count-based' do
      Arch[5,1].hash.must_equal Arch[5,1].hash
    end
  end

  describe '#to_s' do
    it 'has an I/O String representation' do
      Arch[5,1].to_s.must_equal '5/1'
      Arch[4,2].to_s.must_equal '4/2'
    end
  end
  end end
