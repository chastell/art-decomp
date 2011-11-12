module ArtDecomp module CoreExtensions::String

  def dc_expand columns = 0...size
    return [self] unless include? ArtDecomp::DontCare.to_s
    offsets = columns.sort
    i = index ArtDecomp::DontCare.to_s, offsets.shift until columns.include? i or offsets.empty?
    return [self] unless columns.include? i
    zero,    one    = dup, dup
    zero[i], one[i] = '0', '1'
    [zero.extend(CoreExtensions::String).dc_expand(columns), one.extend(CoreExtensions::String).dc_expand(columns)].flatten
  end

end end
