module Enumerable

  def every_pair
    each_with_index do |a, i|
      each_with_index do |b, j|
        yield a, b if i < j
      end
    end
  end

end
