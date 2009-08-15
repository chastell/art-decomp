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
    # FIXME: this is plain ugly
    a, b = @lines.pairs.find do |a, b|
      found = false
      if a[/\s.*$/] == b[/\s.*$/]
        a_ins = a.split.first
        b_ins = b.split.first
        a_ins.size.times do |i|
          if a_ins[0...i] == b_ins[0...i] and a_ins[i+1..-1] == b_ins[i+1..-1]
            found = true
            break
          end
        end
      end
      found
    end
    if a and b
      char = nil
      a.size.times do |i|
        if a[0...i] == b[0...i] and a[i+1..-1] == b[i+1..-1]
          char = i
          break
        end
      end
      @lines.delete a
      @lines.delete b
      @lines << (a[0...char] + DontCare + a[char+1..-1])
      combine_matching
      @lines.sort!
    end
  end

  def drop_overlapping
    @lines.reject! do |line|
      @lines.any? { |l| line != l and line[/\s.*$/] == l[/\s.*$/] and line =~ Regexp.new("^#{l.split.first.tr DontCare, '.'}\s") }
    end
  end

end end
