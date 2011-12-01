module ArtDecomp module CoreExtensions::Integer
  def bits
    (0...to_s(2).size).select { |bit| self[bit] == 1 }.extend CoreExtensions::Enumerable
  end

  def log2_ceil
    return 0 if self == 0 or self == 1
    (self - 1).to_s(2).size
  end
end end
