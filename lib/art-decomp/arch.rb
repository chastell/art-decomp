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

end end