module ArtDecomp class DecTree
  extend Forwardable

  def initialize decs = []
    self.decs = decs
  end

  def_delegators :decs, :<<, :pop

  def == other
    self.decs == other.decs
  end

  def dup
    self.class.new decs.dup
  end

  protected

  attr_accessor :decs
end end
