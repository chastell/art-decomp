class String

  def dc_expand columns = (0...size).to_a
    return [self] unless include? ArtDecomp::DontCare
    offsets = columns.dup
    i = index ArtDecomp::DontCare.to_s, offsets.shift until columns.include? i or offsets.empty?
    return [self] if i.nil?
    zero,    one    = dup, dup
    zero[i], one[i] = '0', '1'
    [zero.dc_expand(columns), one.dc_expand(columns)].flatten
  end

end
