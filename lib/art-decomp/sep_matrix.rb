module ArtDecomp
  class SepMatrix
    def self.from_blanket(blanket)
      size = (blanket.ints.max || 0).to_s(2).size
      ones = (1 << size) - 1
      matrix = (0...size).map do |bit|
        ones ^ blanket.ints.select { |int| int[bit] == 1 }.inject(0, :|)
      end
      (0...matrix.size).select { |i| matrix[i] == ones }.each do |i|
        mask = 1 << i
        matrix.map! { |int| int ^ mask }
        matrix[i] = 0
      end
      new matrix
    end

    def self.from_seps(seps)
      size = (seps.max || 0).to_s(2).size
      matrix = Array.new size, 0
      seps.map(&:bits).each do |a, b|
        matrix[a] |= 1 << b
        matrix[b] |= 1 << a
      end
      new matrix
    end

    def initialize(matrix)
      matrix.pop until matrix.empty? or matrix.last.nonzero?
      @matrix = matrix
    end

    def ==(other)
      @matrix == other.matrix
    end

    def &(other)
      smaller, larger = [@matrix, other.matrix].sort_by(&:size)
      SepMatrix.new larger.zip(smaller).map { |a, b| a && b ? a & b : b }.compact
    end

    def -(other)
      SepMatrix.new @matrix.zip(other.matrix).map { |a, b| a && b ? a & ~b : a }
    end

    def |(other)
      smaller, larger = [@matrix, other.matrix].sort_by(&:size)
      SepMatrix.new larger.zip(smaller).map { |a, b| a && b ? a | b : a }
    end

    alias + |

    def conflicts_of(block)
      block.bits.map { |bit| @matrix[bit] || 0 }.inject 0, :|
    end

    def empty?
      @matrix.all?(&:zero?)
    end

    def r_adm(int)
      conflicts = []
      int.bits.each do |bit|
        mask = 1 << bit
        slot = conflicts.index { |row| (row & (matrix[bit] || 0)).zero? }
        slot ? (conflicts[slot] |= mask) : (conflicts << mask)
      end
      conflicts.size.log2_ceil
    end

    def matrix_size
      @matrix.size
    end

    def size
      @matrix.map(&:bits).map(&:size).inject(0, :+) / 2
    end

    def subset?(other)
      self & other == self
    end

    def superset?(other)
      self & other == other
    end

    protected

    attr_reader :matrix
  end
end
