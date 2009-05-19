describe Enumerable do

  it 'should provide an Enumerator for consecutive element pairs' do
    set = Set[1,2,3,4]
    set.pairs.to_a.should == [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
  end

  it 'should fall back to #combination for the pair selection if possible' do
    array = [1,2,3,4]
    array.should_receive(:combination).with 2
    array.pairs
  end

  it 'should have a method to get all possible combinations of the passed elements' do
    source = [[:a,:b], [:c], [:d,:e,:f]]
    Enumerable.all_combinations(source).should == [[:a,:c,:d], [:a,:c,:e], [:a,:c,:f],
                                                   [:b,:c,:d], [:b,:c,:e], [:b,:c,:f]]
  end

end
