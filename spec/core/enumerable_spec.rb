describe Enumerable do

  describe '#pairs' do

    it 'provides an Enumerator for consecutive element pairs' do
      set = Set[1,2,3,4]
      set.pairs.is_a? Enumerator
      set.pairs.to_a.should == [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
    end

    it 'falls back to #combination for the pair selection if possible' do
      array = [1,2,3,4]
      array.should_receive(:combination).with 2
      array.pairs
    end

  end

end
