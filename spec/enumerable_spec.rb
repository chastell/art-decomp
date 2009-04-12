describe Enumerable do

  it 'should provide an Enumerator for consecutive element pairs' do
    set = Set[1,2,3,4]
    set.pairs.to_a.should == [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
  end

end
