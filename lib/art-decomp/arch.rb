module ArtDecomp class Arch

  attr_reader :pins, :pons

  def self.[] pins, pons
    new pins, pons
  end

  def initialize pins, pons
    @pins, @pons = pins, pons
  end

  def == other
    [@pins, @pons] == [other.pins, other.pons]
  end

  def cells archs
    pons = archs.select { |a| a.pins >= @pins }.map(&:pons).max
    (@pons % pons).zero? ? @pons / pons : @pons / pons + 1 rescue nil
  end

  alias eql? ==

  def hash
    @pins.hash ^ @pons.hash
  end

  def to_s
    "#{pins}/#{pons}"
  end

end end
