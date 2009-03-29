describe Graph do

  before do
    blanket = Blanket[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    seps    = Set[Sep[4,6], Sep[5,9], Sep[5,7], Sep[7,9]]
    @graph  = Graph.new blanket, seps
  end

  it 'should initialise properly from a Blanket and a Set of Seps' do
    @graph.vertices.should == Set[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    @graph.edges.should    == Set[Set[B[3,4], B[5,6]], Set[B[5,6], B[7]], Set[B[8,9], B[7]], Set[B[5,6], B[8,9]]]
  end

  it 'should properly compute vertex degrees' do
    degrees = {B[1,2] => 0, B[3,4] => 1, B[5,6] => 3, B[7] => 2, B[8,9] => 2}
    degrees.each { |vert, deg| @graph.degree(vert).should == deg }
  end

end
