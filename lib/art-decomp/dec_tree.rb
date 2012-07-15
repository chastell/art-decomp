module ArtDecomp class DecTree
  def initialize decs
    self.decs = decs
  end

  def == other
    self.decs == other.decs
  end

  protected

  attr_accessor :decs
end end
