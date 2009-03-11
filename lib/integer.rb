class Integer

  # FIXME: consider right-shifting self and counting ones
  def bits
    (0...to_s(2).size).select { |bit| self[bit] == 1 }
  end

end
