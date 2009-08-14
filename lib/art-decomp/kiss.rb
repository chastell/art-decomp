module ArtDecomp class KISS

  def initialize kiss
    @kiss = kiss
  end

  def formatted
    lines = @kiss.lines.sort.uniq
    lines.map do |line|
      line unless lines.any? { |l| line != l and line =~ Regexp.new("^#{l.split.first.tr '-', '.'}") }
    end.join
  end

end end
