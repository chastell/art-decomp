require_relative '../spec_helper'

module ArtDecomp describe SepMatrix do
  let(:sep_01) { SepMatrix.new [
    0b010,
    0b001,
    0b000,
  ] }
  let(:sep_01_02) { SepMatrix.new [
    0b110,
    0b001,
    0b001,
  ] }
  let(:sep_01_02_03_04_12_13_14) { SepMatrix.new [
    0b11110,
    0b11101,
    0b00011,
    0b00011,
    0b00011,
  ] }
  let(:sep_01_02_03_04_13_14) { SepMatrix.new [
    0b11110,
    0b11001,
    0b00001,
    0b00011,
    0b00011,
  ] }
  let(:sep_01_02_12) { SepMatrix.new [
    0b110,
    0b101,
    0b011,
  ] }
  let(:sep_01_12) { SepMatrix.new [
    0b010,
    0b101,
    0b010,
  ] }
  let(:sep_02) { SepMatrix.new [
    0b100,
    0b000,
    0b001,
  ] }
  let(:sep_03_04_13_14) { SepMatrix.new [
    0b11000,
    0b11000,
    0b00000,
    0b00011,
    0b00011,
  ] }
  let(:sep_12) { SepMatrix.new [
    0b000,
    0b100,
    0b010,
  ] }

  describe '.from_blanket' do
    it 'builds upon separations provided by a Blanket' do
      blanket = Blanket[B[0], B[1,2], B[2,3,4]]
      SepMatrix.from_blanket(blanket).must_equal sep_01_02_03_04_13_14
    end
  end

  describe '#==' do
    it 'compares SepMatrices properly' do
      SepMatrix.new([]).must_equal           SepMatrix.new []
      SepMatrix.new([0b0]).must_equal        SepMatrix.new [0b0]
      SepMatrix.new([0b10, 0b01]).must_equal SepMatrix.new [0b10, 0b01]
      SepMatrix.new([0b10, 0b01]).wont_equal SepMatrix.new [0b10, 0b10]
    end
  end

  describe '#&' do
    it 'ANDs the SepMatrices together' do
      (sep_01_12 & sep_01_02).must_equal sep_01
      (sep_01_02_03_04_13_14 & sep_01_02_12).must_equal sep_01_02
      (sep_01_02_12 & sep_01_02_03_04_13_14).must_equal sep_01_02
    end
  end

  describe '#-' do
    it 'subtracts the second SepMatrix from the first' do
      (sep_01_12 - sep_01).must_equal    sep_12
      (sep_01_02 - sep_01).must_equal    sep_02
      (sep_01_12 - sep_01_02).must_equal sep_12
      (sep_01_02 - sep_01_12).must_equal sep_02
      (sep_01_02_03_04_13_14 - sep_01_02_12).must_equal sep_03_04_13_14
      (sep_01_02_12 - sep_01_02_03_04_13_14).must_equal sep_12
    end
  end

  describe '#|' do
    it 'ORs the SepMatrices together' do
      (sep_01_12 | sep_01_02).must_equal sep_01_02_12
      (sep_01_02_03_04_13_14 | sep_01_02_12).must_equal sep_01_02_03_04_12_13_14
      (sep_01_02_12 | sep_01_02_03_04_13_14).must_equal sep_01_02_03_04_12_13_14
    end
  end

  describe '#sep_count' do
    it 'returns the number of separations' do
      SepMatrix.new([]).sep_count.must_equal           0
      SepMatrix.new([0b00, 0b00]).sep_count.must_equal 0
      sep_01.sep_count.must_equal                      1
      sep_01_02.sep_count.must_equal                   2
      sep_01_02_03_04_12_13_14.sep_count.must_equal    7
    end
  end
end end
