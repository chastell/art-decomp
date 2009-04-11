module Enumerable

  def every_pair
    # FIXME: use #combination where feasible
    each_with_index do |a, i|
      each_with_index do |b, j|
        yield a, b if i < j
      end
    end
  end

  def pairs
    # FIXME: use #combination where feasible
    enum_for :every_pair
  end

end
