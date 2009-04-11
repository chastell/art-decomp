module Enumerable

  def every_pair &block
    # FIXME: use #combination where feasible
    pairs.each &block
  end

  def pairs
    # FIXME: use #combination where feasible
    Enumerator.new do |yielder|
      each_with_index do |a, i|
        each_with_index do |b, j|
          yielder.yield a, b if i < j
        end
      end
    end
  end

end
