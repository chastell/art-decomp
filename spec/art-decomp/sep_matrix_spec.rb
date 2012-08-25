require_relative '../spec_helper'

module ArtDecomp describe SepMatrix do
  describe '.from_blanket' do
    it 'builds upon separations provided by a Blanket' do
      blanket = Blanket[B[0], B[1,2], B[2,3,4]]
      SepMatrix.from_blanket(blanket).must_equal SepMatrix.new [
        0b11110,
        0b11001,
        0b00001,
        0b00011,
        0b00011,
      ]
    end
  end

  describe '#==' do
    it 'compares SepMatrices properly' do
      SepMatrix.new([]).must_equal SepMatrix.new []
    end
  end

  describe '#&' do
    it 'ANDs the SepMatrices together' do
      a = SepMatrix.new [
        0b010,
        0b101,
        0b010,
      ]
      b = SepMatrix.new [
        0b110,
        0b000,
        0b011,
      ]
      (a & b).must_equal SepMatrix.new [
        0b010,
        0b000,
        0b010,
      ]
    end
  end

  describe '#|' do
    it 'ORs the SepMatrices together' do
      a = SepMatrix.new [
        0b010,
        0b101,
        0b010,
      ]
      b = SepMatrix.new [
        0b110,
        0b000,
        0b011,
      ]
      (a | b).must_equal SepMatrix.new [
        0b110,
        0b101,
        0b011,
      ]
    end
  end
end end
