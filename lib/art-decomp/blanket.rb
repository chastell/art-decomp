module ArtDecomp
  class Blanket
    attr_reader :ints

    def self.[](*ints)
      new ints
    end

    def self.from_array(array)
      ints = Hash.new 0
      array.each.with_index { |enc, i| ints[enc] |= 1 << i }

      ints.each_key { |enc| ints[enc] |= ints[DontCare] }
      ints.delete DontCare unless ints.size <= 1

      new ints.values
    end

    def initialize(ints)
      @ints = ints.reject do |i|
        ints.any? { |j| i != j and i & j == i }
      end.to_set.delete(0).freeze
    end

    def *(other)
      ints = []
      @ints.each do |this_int|
        other.ints.each do |other_int|
          ints << (this_int & other_int)
        end
      end
      Blanket.new ints
    end

    def ==(other)
      @ints == other.ints
    end

    def encoding(bits)
      encs = encodings bits
      raise AmbiguousEncodingQuery unless encs.size == 1
      encs.first
    end

    def encodings(bits) # rubocop:disable AbcSize
      sorted = @ints.sort
      width = sorted.size.log2_ceil
      encs = @ints.select { |int| int & bits == bits }
                  .map { |int| sorted.index(int) }
                  .map { |i| i.to_s(2).rjust width, '0' }
      encs.empty? or encs.size == @ints.size ? [DontCare.to_s * width] : encs
    end

    alias eql? ==

    def hash
      @ints.hash
    end

    def inspect
      ints = @ints.map(&:bits).sort.map { |bl| "B[#{bl.join ','}]" }.join ', '
      "Blanket[#{ints}]"
    end

    def pins
      @ints.size.log2_ceil
    end

    def sep_matrix
      SepMatrix.from_blanket self
    end

    def seps
      potential = @ints.inject(0, :|).bits.pairs.map { |a, b| Sep[a,b] }
      not_separate = @ints.map { |i| i.bits.pairs.map { |a, b| Sep[a,b] } }.flatten
      (potential - not_separate).to_set
    end

    def size
      @ints.size
    end

    alias to_s inspect
  end
end
