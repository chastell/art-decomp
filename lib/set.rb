class Set

  # FIXME: consider an algorithm with lesser complexity
  def r_adm int
    seps = select { |sep| int & sep == sep }
    subblocks = Set[]
    int.bits.each do |elem|
      placed = false
      subblocks.each do |subblock|
        extended = subblock + [elem]
        unless seps.any? { |sep| ArtDecomp::B[*extended] & sep == sep }
          subblock << elem
          placed = true
          break
        end
      end
      subblocks << [elem] unless placed
    end
    size = subblocks.size
    return 0 if size == 0 or size == 1
    (size - 1).to_s(2).size
  end

end
