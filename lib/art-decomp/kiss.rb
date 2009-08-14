module ArtDecomp class KISS

  def initialize lines
    @lines = lines
  end

  def formatted
    @lines.sort.uniq.map do |line|
      line unless @lines.any? { |l| line != l and line[/\s.*$/] == l[/\s.*$/] and line =~ Regexp.new("^#{l.split.first.tr '-', '.'}\s") }
    end.compact.join("\n") + "\n"
  end

end end
