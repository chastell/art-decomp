class String

  def dc_expand columns = (0...size).to_a
    return [self] unless self.include? ArtDecomp::DontCare
    offsets = columns.dup
    i = self.index ArtDecomp::DontCare.to_s, offsets.shift until columns.include? i or offsets.empty?
    return [self] if i.nil?
    zero = self[0...i] + '0' + self[i+1..-1]
    one  = self[0...i] + '1' + self[i+1..-1]
    [zero.dc_expand(columns), one.dc_expand(columns)].flatten
  end

end
