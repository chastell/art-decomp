module Enumerable

  def every_pair
    each_with_index do |a, i|
      each_with_index do |b, j|
        yield a, b if i < j
      end
    end
  end

  def pairs
    return combination(2) if respond_to? :combination
    Enumerator.new do |yielder|
      each_with_index do |a, i|
        each_with_index do |b, j|
          yielder.yield a, b if i < j
        end
      end
    end
  end

end
