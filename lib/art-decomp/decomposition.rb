module ArtDecomp class Decomposition
  def initialize fsm, u, v, qu, qv, g
    @fsm, @u, @v, @qu, @qv, @g = fsm, u, v, qu, qv, g
  end

  def == other
    [@fsm, @u, @v, @qu, @qv, @g] == [other.fsm, other.u, other.v, other.qu, other.qv, other.g]
  end

  def disjoint?
    (@u & @v).empty?
  end

  alias eql? ==

  def f_kiss
    @fsm.to_kiss
  end

  def final? archs
    pins = archs.map(&:pins).max
    @v.size + @qv.pins <= pins and @u.size + @qu.pins + @g.pins <= pins
  end

  def g_arch
    Arch[@v.size + @qv.pins, @g.pins]
  end

  def g_cells archs
    Arch[@v.size + @qv.pins, @g.pins].cells archs
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

  def h_arch
    Arch[@u.size + @qu.pins + @g.pins, @fsm.output_count + @qu.pins + @qv.pins]
  end

  def h_cells archs
    Arch[@u.size + @qu.pins + @g.pins, @fsm.output_count + @qu.pins + @qv.pins].cells archs
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
      "#{q} #{qu} #{qv}"
    end
    KISS.new(lines).formatted false
  end

  def sensible? archs
    @v.size + @qv.pins <= archs.map(&:pins).max and @u.size + @qu.pins + @g.pins < @fsm.input_count + @fsm.beta_q.pins
  end

  def symbolic?
    @qu.size > 2
  end

  def to_kiss
    <<-KISS.gsub(/^ +/, '')
      .qu #{@qu.inspect}
      .qv #{@qv.inspect}
      .g  #{@g.inspect}

      .dec F
      .inputs #{kiss_pins fsm.input_count, 'x'}
      .state q
      .next_state qp
      .outputs #{kiss_pins fsm.output_count, 'y'}
      #{f_kiss.strip}
      .e

      .dec Q
      .state q
      .next_state qu
      .outputs #{kiss_pins qv.pins, 'qv'}
      #{q_kiss.strip}
      .e

      .dec G
      .inputs #{kiss_pins v, 'x'} #{kiss_pins qv.pins, 'qv'}
      .outputs #{kiss_pins g.pins, 'g'}
      #{g_kiss.strip}
      .e

      .dec H
      .inputs #{kiss_pins u, 'x'} #{kiss_pins g.pins, 'g'}
      .state qu
      .next_state qup
      .outputs #{kiss_pins qv.pins, 'qvp'} #{kiss_pins fsm.output_count, 'y'}
      #{h_kiss.strip}
      .e
    KISS
  end

  def valid?
    @g.seps.subset?((@fsm.beta_x(@v) * @qv).seps) and @fsm.beta_f.seps.subset?((@fsm.beta_x(@u) * @qu * @g).seps)
  end

  protected
  public

  attr_reader :fsm, :u, :v, :qu, :qv, :g

  private

  # FIXME: this should really move to KISS
  def kiss_pins pins, name
    pins = 0...pins if pins.is_a? Integer
    pins = pins.to_a.sort if pins.is_a? Set
    pins.map { |i| name + i.to_s }.join ' '
  end
end end
