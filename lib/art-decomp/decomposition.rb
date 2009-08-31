module ArtDecomp class Decomposition

  def initialize fsm, u, v, qu, qv, g
    @fsm, @u, @v, @qu, @qv, @g = fsm, u, v, qu, qv, g
  end

  def == other
    [@fsm, @u, @v, @qu, @qv, @g] == [other.fsm, other.u, other.v, other.qu, other.qv, other.g]
  end

  def g_kiss
    require 'pp'
    pp self unless valid?
    lines = []
    rows = (@fsm.beta_x(@v) * @qv).ints
    rows.each do |row|
      v  = @fsm.x_encoding @v, row
      qv = @qv.encoding row
      g  = @g.encoding row
      lines << "#{v}#{qv} #{g}"
    end
    KISS.new(lines).formatted
  end

  def h_kiss
    lines = []
    rows = (@fsm.beta_x(@u) * @g * @qu).ints
    rows.each do |row|
      u   = @fsm.x_encoding @u, row
      qu  = @qu.encoding row
      qup = @qu.encoding @fsm.state_rows_of_next_state_of(row)
      qvp = @qv.encoding @fsm.state_rows_of_next_state_of(row)
      y   = @fsm.y_encoding row
      qu  = '*' if qu  =~ /^-+$/
      qup = '*' if qup =~ /^-+$/
      # FIXME: use only the encoding(s) really mapped from this row
      @g.encodings(row).each do |g|
        lines << "#{u}#{g} #{qu} #{qup} #{qvp}#{y}"
      end
    end
    KISS.new(lines).formatted
  end

  def hash
    @fsm.hash ^ @u.hash ^ @v.hash ^ @qu.hash ^ @qv.hash ^ @g.hash
  end

  def valid?
    @g.seps.subset? (@fsm.beta_x(@v) * @qv).seps and @fsm.beta_f.seps.subset? (@fsm.beta_x(@u) * @qu * @g).seps
  end

  protected

  attr_reader :fsm, :u, :v, :qu, :qv, :g

end end
