module ArtDecomp class Arch
  attr_reader :pins, :pons

  class << self
    alias [] new
  end

  def initialize pins, pons
    @pins, @pons = pins, pons
  end

  def == other
    pins == other.pins and pons == other.pons
  end

  def <=> other
    (other.pins <=> pins).nonzero? or other.pons <=> pons
  end

  def cells archs
    max_pons = archs.select { |a| a.pins >= pins }.map(&:pons).max
    return Infinity unless max_pons
    (pons % max_pons).zero? ? pons / max_pons : pons / max_pons + 1
  end

  alias eql? ==

  def hash
    pins.hash ^ pons.hash
  end

  def to_s
    "#{pins}/#{pons}"
  end
end end
