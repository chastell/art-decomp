describe Enumerable do

  it 'should provide consecutive element pairs' do
    array = [5,1,3,4]
    result = []
    array.every_pair { |a,b| result << [a,b] }
    result.should == [[5,1], [5,3], [5,4], [1,3], [1,4], [3,4]]
  end

end
