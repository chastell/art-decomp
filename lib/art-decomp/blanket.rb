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
    @ints = ints.to_set.delete 0
  end

  def == other
    @ints == other.ints
  end

  def hash
    @ints.hash
  end

  def inspect
    blocks = @ints.map { |i| (0...i.to_s(2).size).select { |bit| i[bit] == 1 } }
    blocks = blocks.sort.map { |bl| "B[#{bl.join ','}]" }
    "Blanket[#{blocks.join ', '}]"
  end

end end
