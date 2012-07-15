module ArtDecomp class DecTree
  extend Forwardable

  def initialize decs = []
    self.decs = decs
  end

  def == other
    self.decs == other.decs
  end

  def_delegators :decs, :<<

  protected

  attr_accessor :decs
end end
