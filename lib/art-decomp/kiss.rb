module ArtDecomp class KISS

  def initialize lines
    @lines = lines
  end

  def formatted
    @lines.sort!
    @lines.uniq!
    drop_overlapping
    combine_matching
    @lines.join("\n") + "\n"
  end

  private

  def combine_matching
    a, b, i = find_matching
    while a and b and i
      @lines.delete a
      @lines.delete b
      @lines << a[0...i] + DontCare + a[i+1..-1]
      a, b, i = find_matching
    end
    @lines.sort!
  end

  def drop_overlapping
    @lines.reject! do |line|
      @lines.any? { |l| line != l and line[/\s.*$/] == l[/\s.*$/] and line =~ Regexp.new("^#{l.split.first.tr DontCare, '.'}\s") }
    end
  end

  def find_matching
    @lines.pairs.each do |a, b|
      if a[/\s.*$/] == b[/\s.*$/]
        a.size.times do |i|
          if a[0...i] == b[0...i] and a[i+1..-1] == b[i+1..-1]
            return a, b, i
          end
        end
      end
    end
    nil
  end

end end
