module ArtDecomp module CoreExtensions module Integer
  def bits
    (0...to_s(2).size).select { |bit| self[bit] == 1 }
  end

  def log2_ceil
    return 0 if self == 0 or self == 1 # rubocop:disable NumericPredicate
    (self - 1).to_s(2).size
  end
end end end
