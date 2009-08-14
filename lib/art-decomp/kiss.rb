module ArtDecomp class KISS

  def initialize lines
    @lines = lines
  end

  def formatted
    lines = @lines.sort.uniq
    lines.map do |line|
      line unless lines.any? { |l| line != l and line =~ Regexp.new("^#{l.split.first.tr '-', '.'}") }
    end.compact.join("\n") + "\n"
  end

end end
