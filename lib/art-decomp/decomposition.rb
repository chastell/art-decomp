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

  def h_kiss
    lines = []
    (@fsm.beta_x(@u) * @g * @qu).ints.each do |row|
      u   = @u.map { |i| @fsm.x_encoding i, row }.join
      g   = @g.encoding  row
      qu  = @qu.encoding row
      qup = @qu.encoding @fsm.state_rows_of_next_state_of(row)
      qvp = @qv.encoding @fsm.state_rows_of_next_state_of(row)
      y   = @fsm.y_encoding row
      lines << "#{u}#{g} #{qu} #{qup} #{qvp}#{y}"
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
