module ArtDecomp
  class KISS
    def initialize(lines)
      @lines = lines
    end

    def formatted(compact = true)
      @lines.sort!
      @lines.uniq!
      drop_overlapping if compact
      combine_matching if compact
      @lines.join("\n") + "\n"
    end

    private

    def combine_matching
      a, b, i = find_matching
      while a and b and i
        @lines.delete a
        @lines.delete b
        @lines << a[0...i] + DontCare.to_s + a[i+1..-1]
        a, b, i = find_matching
      end
      @lines.sort!
    end

    def drop_overlapping
      @lines.reject! do |line|
        @lines.any? do |l|
          line != l and
            line[/\s.*$/] == l[/\s.*$/] and
            line =~ Regexp.new("^#{l.split.first.tr DontCare.to_s, '.'}\s")
        end
      end
    end

    def find_matching # rubocop:disable AbcSize
      @lines.pairs.each do |a, b|
        next unless a[/\s.*$/] == b[/\s.*$/]
        a.size.times do |i|
          return a, b, i if a[0...i] == b[0...i] and a[i+1..-1] == b[i+1..-1]
        end
      end
      nil
    end
  end
end
