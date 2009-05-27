module ArtDecomp class Decomposition

  def initialize fsm, u, v, qu, qv, g
    @fsm, @u, @v, @qu, @qv, @g = fsm, u, v, qu, qv, g
  end

  def == other
    [@fsm, @u, @v, @qu, @qv, @g] == [other.fsm, other.u, other.v, other.qu, other.qv, other.g]
  end

  def g_kiss
    lines = []
    rows = (@fsm.beta_x(@v) * @qv).ints
    rows.delete_if { |row| rows.any? { |other| other != row and other & row == other } }
    rows.each do |row|
      lines << @v.map { |i| @fsm.x_encoding(i, row) }.join + @qv.encoding(row) + ' ' + @g.encodings(row).first
    end
    lines.sort.uniq.join("\n") + "\n"
  end

  def h_kiss
    lines = []
    rows = (@fsm.beta_x(@u) * @g * @qu).ints
    rows.delete_if { |row| rows.any? { |other| other != row and other & row == other } }
    rows.each do |row|
      u   = @u.map { |i| @fsm.x_encoding i, row }.join
      qu  = @qu.encoding row
      qup = @qu.encoding @fsm.state_rows_of_next_state_of(row)
      qvp = @qv.encoding @fsm.state_rows_of_next_state_of(row)
      y   = @fsm.y_encoding row
      qu  = '*' if qu  =~ /^-+$/
      qup = '*' if qup =~ /^-+$/
      @g.encodings(row).each do |g|
        lines << "#{u}#{g} #{qu} #{qup} #{qvp}#{y}"
      end
    end
    lines.sort.uniq.join("\n") + "\n"
  end

  def hash
    @fsm.hash ^ @u.hash ^ @v.hash ^ @qu.hash ^ @qv.hash ^ @g.hash
  end

  protected

  attr_reader :fsm, :u, :v, :qu, :qv, :g

end end
