module Enumerable

  def pairs
    respond_to?(:combination) ? combination(2) : to_a.combination(2)
  end

end
