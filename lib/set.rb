class Set

  def hash
    map(&:hash).inject :^
  end unless Set[2305860601668175887].hash == Set[2305860601668175887].hash

  def r_adm int
    # FIXME: consider an algorithm with lesser complexity
    seps = select { |sep| int & sep == sep }
    subblocks = Set[]
    int.bits.each do |elem|
      bit = 1 << elem
      subblock = subblocks.find { |sb| seps.none? { |sep| (sb | bit) & sep == sep } } || 0
      subblocks.delete subblock
      subblocks << (subblock | bit)
    end
    subblocks.size.log2_ceil
  end

end
