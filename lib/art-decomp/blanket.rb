module ArtDecomp class Blanket

  attr_reader :ints

  def self.[] *ints
    new ints
  end

  def self.from_array array
    ints = Hash.new 0
    array.each_with_index do |enc, i|
      ints[enc] |= 1 << i
    end
    ints.each_key do |key|
      ints[key] |= ints[DontCare]
    end unless ints[DontCare].zero?
    ints.delete DontCare unless ints.size <= 1
    new ints.values
  end

  def initialize ints
    @ints = ints.to_set.delete(0).freeze
  end

  def * other
    ints = []
    @ints.each do |this_int|
      other.ints.each do |other_int|
        ints << (this_int & other_int)
      end
    end
    Blanket.new ints
  end

  def == other
    @ints == other.ints
  end

  def encoding bits
    encs = encodings bits
    encs.size == 1 ? encs.first : raise(AmbiguousEncodingQuery, "ambiguous encoding query: block #{bits.bits.join ','}")
  end

  def encodings bits
    sorted = @ints.sort
    width = sorted.size.log2_ceil
    encs = @ints.select { |int| int & bits == bits }.map { |int| sorted.index(int) }.map { |i| i.to_s(2).rjust width, '0' }
    encs.size == 0 or encs.size == @ints.size ? [DontCare.to_s * width] : encs
  end

  alias eql? ==

  def hash
    @ints.hash
  end

  def inspect
    blocks = @ints.map(&:bits).sort.map { |bl| "B[#{bl.join ','}]" }
    "Blanket[#{blocks.join ', '}]"
  end

  def pins
    @ints.size.log2_ceil
  end

  def seps
    potential = @ints.inject(0, :|).bits.pairs.map { |a, b| Sep[a,b] }
    not_separate = @ints.map{ |i| i.bits.pairs.map { |a, b| Sep[a,b] } }.flatten
    (potential - not_separate).to_set
  end

  def size
    @ints.size
  end

end end
