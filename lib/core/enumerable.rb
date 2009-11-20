module Enumerable

  def self.all_combinations source
    result_count = source.map(&:size).inject :*
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
    respond_to?(:combination) ? combination(2) : to_a.combination(2)
  end

end
