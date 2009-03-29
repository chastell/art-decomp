describe Graph do

  it 'should initialise properly from a Blanket and a Set of Seps' do
    blanket = Blanket[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    seps    = Set[Sep[4,6], Sep[5,9], Sep[5,7], Sep[7,9]]
    graph   = Graph.new blanket, separations
    graph.vertices.should == Set[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    graph.edges.should    == Set[Set[B[3,4], B[5,6]], Set[B[5,6], B[7]], Set[B[8,9], B[7]], Set[B[5,6], B[8,9]]]
  end

end
