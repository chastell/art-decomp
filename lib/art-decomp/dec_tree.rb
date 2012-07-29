module ArtDecomp class DecTree
  extend Forwardable

  def initialize archs, decs = []
    self.archs = archs
    self.decs  = decs
  end

  def_delegators :decs, :<<, :pop

  def == other
    self.decs == other.decs
  end

  def dup
    self.class.new archs, decs.dup
  end

  def to_vhdl name
    ERB.new(File.read('lib/art-decomp/dec_tree.vhdl.erb'), nil, '%').result binding
  end

  protected

  attr_accessor :archs, :decs

  private

  def cells
    decs.map { |dec| dec.g_cells archs }.inject(:+) + decs.last.h_cells(archs)
  end

  def dec_g_blocks
    decs.map do |dec|
      Hash[(dec.fsm.beta_x(dec.v) * dec.qv).ints.map do |row|
        v  = dec.fsm.x_encoding dec.v, row
        qv = dec.qv.encoding row
        g  = dec.g.encoding row
        ["#{v}#{qv}", g] unless g =~ /\A-+\Z/
      end.compact.sort]
    end
  end

  def dec_sizes
    decs.map.with_index do |dec, d|
      OpenStruct.new(
        x:   dec.fsm.input_count - 1,
        q:   state_pins(d) - 1,
        qu:  state_pins(d) - dec.qv.pins - 1,
        qv:  dec.qv.pins - 1,
        g_i: dec.v.size + dec.qv.pins - 1,
        g_o: dec.g.pins - 1,
      )
    end
  end

  def dec_structures
    decs.map.with_index do |dec, d|
      OpenStruct.new(
        x:   d.zero? ? 'fsm_i' : "(#{decs[d-1].u.sort.map { |x| "d#{d-1}_x(#{x})" }.join ' & '} & d#{d-1}_g_o)",
        q:   d.zero? ? 'fsm_q' : "d#{d-1}_qu",
        qu:  "d#{d}_q(0 to #{state_pins(d) - dec.qv.pins - 1})",
        qv:  "d#{d}_q(#{state_pins(d) - decs[d].qv.pins} to #{state_pins(d) - 1})",
        g_i: "(#{(dec.v.sort.map { |x| "d#{d}_x(#{x})" } + ["d#{d}_qv"]).join ' & '})",
      )
    end
  end

  def first_state
    encoded = ''
    code = nil
    decs.each.with_index do |dec, d|
      codes = Hash[dec.fsm.beta_q.ints.sort.map { |row| [dec.fsm.q_encoding(row), { qu: dec.qu.encoding(row), qv: dec.qv.encoding(row) }] }]
      code ||= codes.keys.first
      encoded.prepend codes[code][:qv]
      encoded.prepend codes[code][:qu] if d == max_d
      code = codes[code][:qu]
      break if code.empty?
    end
    encoded
  end

  def fsm_i_size
    decs.first.fsm.input_count - 1
  end

  def fsm_o_size
    decs.first.fsm.output_count - 1
  end

  def fsm_q_size
    state_pins - 1
  end

  def g_archs
    decs.map { |dec| dec.g_arch.to_s }.join ' '
  end

  def h_arch
    decs.last.h_arch.to_s
  end

  def h_block
    dec = decs.last
    Hash[(dec.fsm.beta_x(dec.u) * dec.g * dec.qu).ints.flat_map do |row|
      u   = dec.fsm.x_encoding dec.u, row
      qu  = dec.qu.encoding row
      qup = dec.qu.encoding dec.fsm.state_rows_of_next_state_of(row)
      qvp = dec.qv.encoding dec.fsm.state_rows_of_next_state_of(row)
      y   = dec.fsm.y_encoding row
      dec.g.encodings(row).map do |g|
        ["#{u}#{g}#{qu}", "#{qup}#{qvp}#{y}"] unless "#{qup}#{qvp}#{y}" =~ /\A-+\Z/
      end.compact
    end.sort]
  end

  def h_i_size
    decs.last.u.size + decs.last.qu.pins + decs.last.g.pins - 1
  end

  def h_i_structure
    (decs.last.u.sort.map { |x| "d#{max_d}_x(#{x})" } + ["d#{max_d}_g_o", "d#{max_d}_qu"]).join ' & '
  end

  def h_o_qp_size
    decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - decs.first.fsm.output_count - 1
  end

  def h_o_size
    decs.last.qu.pins + decs.last.qv.pins + decs.last.fsm.output_count - 1
  end

  def max_d
    decs.size - 1
  end

  def state_pins start = 0
    decs[start..-1].map { |d| d.qv.pins }.inject(:+) + decs.last.qu.pins
  end
end end
