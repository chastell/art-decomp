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

  def hash
    @ints.hash
  end

  def inspect
    blocks = @ints.map { |i| (0...i.to_s(2).size).select { |bit| i[bit] == 1 } }
    blocks = blocks.sort.map { |bl| "B[#{bl.join ','}]" }
    "Blanket[#{blocks.join ', '}]"
  end

  def separations
    # FIXME: consider an algorithm with lesser complexity
    seps = Set[]
    singles = 0
    @ints.every_pair { |int1, int2| singles |= int1 ^ int2 }
    singles.bits.every_pair do |elem1, elem2|
      sep = Sep[elem1, elem2]
      found = false
      @ints.each do |int|
        found = true and break if int & sep == sep
      end
      seps << sep unless found
    end
    seps
  end

end end
