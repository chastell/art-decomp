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

  def encoding bits
    sorted = @ints.sort
    encs = @ints.select { |int| int & bits == bits }.map { |int| sorted.index(int) }.map { |i| i.to_s(2).rjust(sorted.size.log2_ceil, '0') }.map(&:to_sym)
    case encs.size
    when 0, @ints.size then DontCare
    when 1 then encs.first
    else raise AmbiguousEncodingQuery, "ambiguous encoding query: block #{bits.bits.join ','}"
    end
  end

  def hash
    @ints.hash
  end

  def inspect
    blocks = @ints.map(&:bits).sort.map { |bl| "B[#{bl.join ','}]" }
    "Blanket[#{blocks.join ', '}]"
  end

  def seps
    # FIXME: consider an algorithm with lesser complexity
    seps = Set[]
    singles = 0
    @ints.pairs.each { |int1, int2| singles |= int1 ^ int2 }
    singles.bits.pairs.each do |elem1, elem2|
      sep = Sep[elem1, elem2]
      seps << sep unless @ints.any? { |int| int & sep == sep }
    end
    seps
  end

  def size
    @ints.size
  end

end end
