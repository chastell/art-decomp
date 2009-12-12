# encoding: UTF-8

module ArtDecomp describe Graph do

  before do
    blanket = Blanket[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    seps    = Set[Sep[4,6], Sep[5,9], Sep[5,7], Sep[7,9]]
    @graph  = Graph.new blanket, seps
  end

  it 'should initialise properly from a Blanket and a Set of Seps' do
    @graph.vertices.should == Set[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    @graph.edges.should    == Set[Set[B[3,4], B[5,6]], Set[B[5,6], B[7]], Set[B[8,9], B[7]], Set[B[5,6], B[8,9]]]
  end

  it 'should drop vertices covered by other vertices upon initialisation' do
    Graph.new(Blanket[B[1,2], B[2]], Set[]).vertices.should == Set[B[1,2]]
  end

  it 'should properly compute vertex degrees' do
    degrees = {B[1,2] => 0, B[3,4] => 1, B[5,6] => 3, B[7] => 2, B[8,9] => 2}
    degrees.each { |vert, deg| @graph.degree(vert).should == deg }
  end

  it 'should return the proper Blanket obtained by colouring the vertices' do
    blanket = @graph.blanket_from_colouring
    blanket.size.should == 3
    blanket.ints.should include(B[1,2,5,6])
  end

  it 'should report whether it’s complete' do
    complete = Graph.new Blanket[B[1], B[2], B[3]], Set[Sep[1,2], Sep[1,3], Sep[2,3]]
    complete.should   be_complete
    @graph.should_not be_complete
  end

  it 'should properly merge until it’s complete and return self' do
    @graph.merge_until_complete!.should be_a(Graph)
    @graph.vertices.size.should == 3
    @graph.vertices.should include(B[1,2,5,6])
    @graph.should be_complete
  end

  it 'should properly merge based on edge weights and return self' do
    b1234 = Blanket[B[1], B[2], B[3], B[4]]
    graph = Graph.new b1234, b1234.seps
    graph.merge_by_edge_labels! { |a, b| a | b }.should be_a(Graph)
    graph.vertices.should == Set[B[1,2,3], B[4]]
    graph.merge_by_edge_labels! { |a, b| a | b }.should be_a(Graph)
    graph.vertices.should == Set[B[1,2,3,4]]
    graph.merge_by_edge_labels! { |a, b| a | b }.should be_a(Graph)
    graph.vertices.should == Set[B[1,2,3,4]]
  end

  it 'should properly merge based on vertex degrees and return self' do
    graph = Graph.new Blanket[B[1], B[2], B[3], B[4], B[5], B[6]], Set[Sep[3,4], Sep[4,5], Sep[4,6], Sep[5,6]]
    graph.merge_by_vertex_degrees!.should be_a(Graph)
    graph.vertices.should == Set[B[1,2,4], B[3], B[5], B[6]]
    graph.merge_by_vertex_degrees!.should be_a(Graph)
    graph.vertices.size.should == 3
  end

  it 'should report a given vertex’s adjacent vertices' do
    @graph.adjacent(B[3,4]).should == Set[B[5,6]]
    @graph.adjacent(B[1,2]).should == Set[]
    @graph.adjacent(B[5,6], B[7]).should == Set[B[3,4], B[8,9]]
  end

  it 'should only create the necessary edges' do
    blanket = Blanket[B[1,2,3], B[1,2,4], B[1,5], B[2,6]]
    Graph.new(blanket, Set[Sep[1,2]]).edges.should == Set[Set[B[1,5], B[2,6]]]
  end

end end
