module Enumerable

  def self.all_combinations source
    result_count = source.map(&:size).inject(:*)
    group_count = 1
    result = []
    source.each do |elems|
      row = []
      group_count.times do
        elems.each do |elem|
          (result_count / group_count / elems.size).times { row << elem }
        end
      end
      group_count *= elems.size
      result << row
    end
    result.transpose
  end

  def pairs
    return combination 2 if respond_to? :combination
    Enumerator.new do |yielder|
      each_with_index do |a, i|
        each_with_index do |b, j|
          yielder.yield a, b if i < j
        end
      end
    end
  end

end
