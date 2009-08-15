module ArtDecomp class KISS

  def initialize lines
    @lines = lines
  end

  def formatted
    @lines.sort!
    @lines.uniq!
    drop_overlapping
    @lines.join("\n") + "\n"
  end

  private

  def drop_overlapping
    @lines.reject! do |line|
      @lines.any? { |l| line != l and line[/\s.*$/] == l[/\s.*$/] and line =~ Regexp.new("^#{l.split.first.tr DontCare, '.'}\s") }
    end
  end

end end
