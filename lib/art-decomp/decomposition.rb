module ArtDecomp class Decomposition

  def initialize fsm, u, v, qu, qv, g
    @fsm, @u, @v, @qu, @qv, @g = fsm, u, v, qu, qv, g
  end

  def == other
    [@fsm, @u, @v, @qu, @qv, @g] == [other.fsm, other.u, other.v, other.qu, other.qv, other.g]
  end

  def g_kiss
    lines = []
    (@fsm.beta_x(@v) * @qv).ints.each do |row|
      lines << @v.map { |i| @fsm.x_encoding(i, row) }.join + @qv.encoding(row) + ' ' + @g.encoding(row)
    end
    # FIXME: drop lines with defined inputs if covered by a row with a don’t-care in the same column
    lines.sort.uniq.join("\n") + "\n"
  end

  def hash
    @fsm.hash ^ @u.hash ^ @v.hash ^ @qu.hash ^ @qv.hash ^ @g.hash
  end

  protected

  attr_reader :fsm, :u, :v, :qu, :qv, :g

end end
