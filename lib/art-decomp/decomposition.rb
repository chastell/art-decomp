module ArtDecomp class Decomposition

  attr_reader :uv_gen, :qu_gen, :qv_gen

  def initialize fsm, u, v, qu, qv, g, opts = {}
    @fsm, @u, @v, @qu, @qv, @g = fsm, u, v, qu, qv, g
    @uv_gen, @qu_gen, @qv_gen = opts.values_at :uv_gen, :qu_gen, :qv_gen
  end

  def == other
    [@fsm, @u, @v, @qu, @qv, @g] == [other.fsm, other.u, other.v, other.qu, other.qv, other.g]
  end

  def decomposable?
    @qu.size > 2
  end

  alias eql? ==

  def f_kiss
    @fsm.to_kiss
  end

  def final? archs
    pins = archs.map(&:pins).max
    @v.size + @qv.pins <= pins and @u.size + @qu.pins + @g.pins <= pins
  end

  def g_kiss
    lines = (@fsm.beta_x(@v) * @qv).ints.map do |row|
      v  = @fsm.x_encoding @v, row
      qv = @qv.encoding row
      g  = @g.encoding row
      "#{v}#{qv} #{g}"
    end
    KISS.new(lines).formatted
  end

  def h_kiss
    lines = (@fsm.beta_x(@u) * @g * @qu).ints.map do |row|
      u   = @fsm.x_encoding @u, row
      qu  = @qu.encoding row
      qup = @qu.encoding @fsm.state_rows_of_next_state_of(row)
      qvp = @qv.encoding @fsm.state_rows_of_next_state_of(row)
      y   = @fsm.y_encoding row
      qu  = '*' if qu  =~ /^-+$/
      qup = '*' if qup =~ /^-+$/
      # FIXME: use only the encoding(s) really mapped from this row
      @g.encodings(row).map do |g|
        "#{u}#{g} #{qu} #{qup} #{qvp}#{y}"
      end
    end.flatten
    KISS.new(lines).formatted
  end

  def hash
    @fsm.hash ^ @u.hash ^ @v.hash ^ @qu.hash ^ @qv.hash ^ @g.hash
  end

  def q_kiss
    lines = @fsm.beta_q.ints.map do |row|
      qu = @qu.encoding row
      qv = @qv.encoding row
      q  = @fsm.q_encoding row
      "#{qu} #{qv}  #{q}"
    end
    KISS.new(lines).formatted
  end

  def sensible?
    @g.pins < @v.size + @qv.pins and (@qu.size < @fsm.beta_q.size or @qv.size < @fsm.beta_q.size)
  end

  def valid?
    @g.seps.subset? (@fsm.beta_x(@v) * @qv).seps and @fsm.beta_f.seps.subset? (@fsm.beta_x(@u) * @qu * @g).seps
  end

  protected

  attr_reader :fsm, :u, :v, :qu, :qv, :g

end end
