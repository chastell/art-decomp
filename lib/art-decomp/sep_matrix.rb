module ArtDecomp class SepMatrix
  def initialize matrix
    @matrix = matrix
  end

  def self.from_blanket blanket
    size = blanket.ints.max.to_s(2).size
    ones = (1 << size) - 1
    matrix = Array.new size, ones

    blanket.ints.each do |int|
      int.bits.pairs.each do |a, b|
        mask = 1 << a | 1 << b
        matrix[a] ^= mask
        matrix[b] ^= mask
      end
    end

    matrix.each_index do |i|
      mask = 1 << i
      matrix[i] ^= mask unless matrix[i][i].zero?
    end

    new matrix
  end

  def == other
    @matrix == other.matrix
  end

  def & other
    smaller, larger = [@matrix, other.matrix].sort_by(&:size)
    SepMatrix.new larger.zip(smaller).map { |a, b| a && b ? a & b : b }.compact
  end

  def - other
    SepMatrix.new @matrix.zip(other.matrix).map { |a, b| a && b ? a & ~b : a }
  end

  def | other
    smaller, larger = [@matrix, other.matrix].sort_by(&:size)
    SepMatrix.new larger.zip(smaller).map { |a, b| a && b ? a | b : a }
  end

  def empty?
    @matrix.all?(&:zero?)
  end

  def sep_count
    @matrix.map(&:bits).map(&:size).inject(0, :+) / 2
  end

  def subset? other
    self & other == self
  end

  protected

  attr_reader :matrix
end end