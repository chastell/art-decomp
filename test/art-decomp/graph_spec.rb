# encoding: UTF-8

require_relative '../spec_helper'

module ArtDecomp describe Graph do

  before do
    blanket = Blanket[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    seps    = Set[Sep[4,6], Sep[5,9], Sep[5,7], Sep[7,9]]
    @graph  = Graph.new blanket, seps
  end

  describe '.new' do

    it 'drops vertices covered by other vertices upon initialisation' do
      Graph.new(Blanket[B[1,2], B[2]], Set[]).vertices.must_equal Set[B[1,2]]
    end

    it 'creates only the necessary edges' do
      blanket = Blanket[B[1,2,3], B[1,2,4], B[1,5], B[2,6]]
      Graph.new(blanket, Set[Sep[1,2]]).edges.must_equal Set[Set[B[1,5], B[2,6]]]
    end

  end

  describe '#adjacent' do

    it 'returns the given vertex’s adjacent vertices' do
      @graph.adjacent(B[3,4]).must_equal Set[B[5,6]]
      @graph.adjacent(B[1,2]).must_equal Set[]
      @graph.adjacent(B[5,6], B[7]).must_equal Set[B[3,4], B[8,9]]
    end

  end

  describe '#blanket_from_colouring' do

    it 'returns the proper Blanket obtained by colouring the vertices' do
      blanket = @graph.blanket_from_colouring
      blanket.size.must_equal 3
      assert blanket.ints.include? B[1,2,5,6]
    end

  end

  describe '#complete?' do

    it 'reports whether it’s complete' do
      complete = Graph.new Blanket[B[1], B[2], B[3]], Set[Sep[1,2], Sep[1,3], Sep[2,3]]
      assert complete.complete?
      refute @graph.complete?
    end

  end

  describe '#degree' do

    it 'returns vertex degrees' do
      degrees = {B[1,2] => 0, B[3,4] => 1, B[5,6] => 3, B[7] => 2, B[8,9] => 2}
      degrees.each { |vert, deg| @graph.degree(vert).must_equal deg }
    end

  end

  describe '#edges' do

    it 'returns the Graph’s edges' do
      @graph.edges.must_equal Set[Set[B[3,4], B[5,6]], Set[B[5,6], B[7]], Set[B[8,9], B[7]], Set[B[5,6], B[8,9]]]
    end

  end

  describe '#merge_by_edge_labels!' do

    it 'merges based on edge weights and returns self' do
      b1234 = Blanket[B[1], B[2], B[3], B[4]]
      graph = Graph.new b1234, b1234.seps
      assert graph.merge_by_edge_labels! { |a, b| a | b }.is_a? Graph
      graph.vertices.must_equal Set[B[1,2,3], B[4]]
      assert graph.merge_by_edge_labels! { |a, b| a | b }.is_a? Graph
      graph.vertices.must_equal Set[B[1,2,3,4]]
      assert graph.merge_by_edge_labels! { |a, b| a | b }.is_a? Graph
      graph.vertices.must_equal Set[B[1,2,3,4]]
    end

  end

  describe '#merge_by_vertex_degrees!' do

    it 'merges based on vertex degrees and returns self' do
      graph = Graph.new Blanket[B[1], B[2], B[3], B[4], B[5], B[6]], Set[Sep[3,4], Sep[4,5], Sep[4,6], Sep[5,6]]
      assert graph.merge_by_vertex_degrees!.is_a? Graph
      graph.vertices.must_equal Set[B[1,2,4], B[3], B[5], B[6]]
      assert graph.merge_by_vertex_degrees!.is_a? Graph
      graph.vertices.size.must_equal 3
    end

  end

  describe '#merge_until_complete!' do

    it 'merges until it’s complete and returns self' do
      assert @graph.merge_until_complete!.is_a? Graph
      @graph.vertices.size.must_equal 3
      assert @graph.vertices.include? B[1,2,5,6]
      assert @graph.complete?
    end

  end

  describe '#vertices' do

    it 'returns the Graph’s vertices' do
      @graph.vertices.must_equal Set[B[1,2], B[3,4], B[5,6], B[7], B[8,9]]
    end

  end

end end
