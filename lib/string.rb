class String

  def dc_expand
    return [self] unless self.include? ArtDecomp::DontCare
    i = self.index ArtDecomp::DontCare.to_s
    zero = self[0...i] + '0' + self[i+1..-1]
    one  = self[0...i] + '1' + self[i+1..-1]
    [zero.dc_expand, one.dc_expand].flatten
  end

end
