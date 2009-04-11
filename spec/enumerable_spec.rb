describe Enumerable do

  it 'should provide consecutive element pairs when called with a block' do
    array = [5,1,3,4]
    result = []
    array.every_pair { |a,b| result << [a,b] }
    result.should == [[5,1], [5,3], [5,4], [1,3], [1,4], [3,4]]
  end

  it 'should provide consecutive element pairs when called as an Enumerator' do
    set = Set[1,2,3,4]
    set.pairs.to_a.should == [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
  end

end
