module ArtDecomp class KISS

  def initialize kiss
    @kiss = kiss
  end

  def formatted
    @kiss.lines.sort.uniq.join
  end

end end
