# encoding: UTF-8

require_relative '../spec_helper'

module ArtDecomp describe Decomposition do
  before do
    @fsm = FSM.from_kiss 'spec/fixtures/fsm'
    @qu  = Blanket[B[0,4,5], B[1,2,3,13,14], B[6,7,8,9,10,11,12], B[15,16,17,18,19]]
    @qv  = Blanket[B[0,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19], B[1,2,18]]
    @g   = Blanket[B[0,2,5,6,7,9,11,15,16,17,18,19], B[1,3,4,8,10,12,13,14]]
    @dec = Decomposition.new @fsm, Set[0,1,3], Set[2], @qu, @qv, @g

    @b  = MiniTest::Mock.new
    @b1 = MiniTest::Mock.new; @b1.expect :pins, 1; @b1.expect :size, 2
    @b2 = MiniTest::Mock.new; @b2.expect :pins, 2; @b2.expect :size, 4
    @b3 = MiniTest::Mock.new; @b3.expect :pins, 3
    @b4 = MiniTest::Mock.new; @b4.expect :pins, 4
  end

  describe '#==' do
    it 'compares Decompositions based on their parts' do
      @dec.must_equal Decomposition.new @fsm, Set[0,1,3], Set[2], @qu, @qv, @g
      @dec.wont_equal Decomposition.new @fsm, Set[2], Set[0,1,3], @qu, @qv, @g
      @dec.wont_equal Decomposition.new @fsm, Set[0,1,3], Set[2], @qv, @qu, @g
    end
  end

  describe '#disjoint?' do
    it 'returns whether the Decomposition is disjoint' do
      assert Decomposition.new(@fsm, Set[0],   Set[1],   @b, @b, @b).disjoint?
      refute Decomposition.new(@fsm, Set[0,1], Set[1],   @b, @b, @b).disjoint?
      refute Decomposition.new(@fsm, Set[1],   Set[0,1], @b, @b, @b).disjoint?
    end
  end

  describe '#eql?' do
    it 'compares Decompositions for the purpose of Hash/Set use' do
      assert @dec.eql? Decomposition.new @fsm, Set[0,1,3], Set[2], @qu, @qv, @g
    end
  end

  describe '#f_kiss' do
    it 'returns the F block’s KISS representation' do
      @dec.f_kiss.must_equal File.read 'spec/fixtures/fsm.f'
    end
  end

  describe '#final?' do
    it 'returns whether the Decomposition is final based on a Set of Archs' do
      assert Decomposition.new(@fsm, Set[0],   Set[1],   @b1, @b3, @b3).final? Set[Arch[5,1]]
      refute Decomposition.new(@fsm, Set[0],   Set[1],   @b1, @b3, @b3).final? Set[Arch[4,2]]
      assert Decomposition.new(@fsm, Set[],    Set[1],   @b1, @b3, @b3).final? Set[Arch[4,2]]
      refute Decomposition.new(@fsm, Set[],    Set[1,2], @b1, @b3, @b3).final? Set[Arch[4,2]]
      refute Decomposition.new(@fsm, Set[],    Set[1],   @b1, @b4, @b3).final? Set[Arch[4,2]]
      assert Decomposition.new(@fsm, Set[0],   Set[1,2], @b1, @b3, @b3).final? Set[Arch[5,1]]
      refute Decomposition.new(@fsm, Set[0,1], Set[2],   @b1, @b3, @b3).final? Set[Arch[5,1]]
      refute Decomposition.new(@fsm, Set[0],   Set[1,2], @b2, @b3, @b3).final? Set[Arch[5,1]]
      refute Decomposition.new(@fsm, Set[0],   Set[1,2], @b1, @b3, @b4).final? Set[Arch[5,1]]
    end
  end

  describe '#g_cells' do
    it 'returns G cell count (if G fits the provided Archs)' do
      Decomposition.new(@fsm, Set[0], Set[1,2], @b, @b2, @b2).g_cells(Set[Arch[5,1]]).must_equal 2
      Decomposition.new(@fsm, Set[0], Set[1,2], @b, @b2, @b2).g_cells(Set[Arch[4,2]]).must_equal 1
      Decomposition.new(@fsm, Set[0], Set[1,2], @b, @b2, @b2).g_cells(Set[Arch[3,2]]).must_be_nil
      Decomposition.new(@fsm, Set[0], Set[1,2], @b, @b2, @b3).g_cells(Set[Arch[4,2]]).must_equal 2
    end
  end

  describe '#g_kiss' do
    it 'returns the G block’s KISS representation' do
      @dec.g_kiss.must_equal File.read 'spec/fixtures/fsm.g'
    end
  end

  describe '#h_cells' do
    it 'returns H cell count (if G fits the provided Archs)' do
      Decomposition.new(@fsm, Set[0], Set[1,2], @b1, @b1, @b2).h_cells(Set[Arch[5,1]]).must_equal 4
      Decomposition.new(@fsm, Set[0], Set[1,2], @b1, @b1, @b2).h_cells(Set[Arch[4,2]]).must_equal 2
      Decomposition.new(@fsm, Set[0], Set[1,2], @b1, @b1, @b2).h_cells(Set[Arch[3,1]]).must_be_nil
      Decomposition.new(@fsm, Set[0], Set[1,2], @b1, @b2, @b2).h_cells(Set[Arch[4,2]]).must_equal 3
    end
  end

  describe '#h_kiss' do
    it 'returns the H block’s KISS representation' do
      @dec.h_kiss.must_equal File.read 'spec/fixtures/fsm.h'
    end

    it 'creates the H block properly, even if the G blanket seems ambiguous' do
      fsm = FSM.from_kiss 'spec/fixtures/opus'
      qu  = Blanket[B[0,1,11,14,15,16,17,18,19,20,30,33,34,35,36,37], B[2,5,7,14,21,24,26,33], B[3,4,10,13,14,22,23,29,32,33], B[6,8,9,12,14,25,27,28,31,33]]
      qv  = Blanket[B[0,2,6,8,10,13,14,15,19,21,25,27,29,32,33,34], B[1,3,4,5,7,9,12,14,20,22,23,24,26,28,31,33], B[11,14,16,17,18,30,33,35,36,37]]
      g   = Blanket[B[0,2,6,8,10,13,14,15,19,21,25,27,29,32,33,34], B[1,3,4,5,7,9,12,14,20,22,23,24,26,28,31,33], B[11,14,16,17,18], B[30,33,35,36,37]]
      decomposition = Decomposition.new fsm.expand_x(Set[0]), Set[1,2,3,4], Set[0], qu, qv, g
      decomposition.h_kiss.must_equal File.read 'spec/fixtures/opus.amb.h'
    end

    it 'properly recodes don’t-care states to *' do
      fsm = FSM.from_kiss 'spec/fixtures/opus'
      qu  = Blanket[B[0,1,2,3,4,20,21], B[0,5,6,7], B[0,8,9,10,11,12,13,14,15,16], B[0,17,18,19]]
      qv  = Blanket[B[0,1,2,6,7,15,16,17,18], B[0,3,4,5,8,9,10,11,12,13,14,19], B[0,20,21]]
      g   = Blanket[B[0,1], B[2,6,7,15,16,17,18], B[3,4,5,8,9,10,11,12,13,14,19], B[20,21]]
      decomposition = Decomposition.new fsm, Set[0,1,3,4], Set[2], qu, qv, g
      decomposition.h_kiss.must_equal File.read 'spec/fixtures/opus.h'
    end
  end

  describe '#hash' do
    it 'hashes Decompositions for the purpose of Hash/Set use' do
      @dec.hash.must_equal Decomposition.new(@fsm, Set[0,1,3], Set[2], @qu, @qv, @g).hash
    end
  end

  describe '#q_kiss' do
    it 'returns the Q block’s KISS representation' do
      @dec.q_kiss.must_equal File.read 'spec/fixtures/fsm.q'
    end
  end

  describe '#sensible?' do
    it 'returns whether it’s sensible, based on the target Archs and G and H blocks’ architectures' do
      q = MiniTest::Mock.new
      q.expect :pins, 3

      fsm = MiniTest::Mock.new
      fsm.expect :input_count, 3
      fsm.expect :beta_q,      q

      refute Decomposition.new(fsm, Set[0],   Set[1,2],   @b2, @b2, @b2).sensible? Set[Arch[3,2]]
      assert Decomposition.new(fsm, Set[0],   Set[1,2],   @b2, @b2, @b2).sensible? Set[Arch[4,1]]
      refute Decomposition.new(fsm, Set[],    Set[0,1,2], @b2, @b2, @b2).sensible? Set[Arch[4,1]]
      refute Decomposition.new(fsm, Set[0],   Set[1,2],   @b2, @b3, @b2).sensible? Set[Arch[4,1]]
      refute Decomposition.new(fsm, Set[0,1], Set[1,2],   @b2, @b2, @b2).sensible? Set[Arch[4,1]]
      refute Decomposition.new(fsm, Set[0],   Set[1,2],   @b3, @b2, @b2).sensible? Set[Arch[4,1]]
      refute Decomposition.new(fsm, Set[0],   Set[1,2],   @b2, @b2, @b3).sensible? Set[Arch[4,1]]
    end
  end

  describe '#symbolic?' do
    it 'returns whether the resulting H block is an FSM' do
      refute Decomposition.new(@fsm, Set[0], Set[1], @b1, @b, @b).symbolic?
      assert Decomposition.new(@fsm, Set[0], Set[1], @b2, @b, @b).symbolic?
    end
  end

  describe '#valid?' do
    it 'returns the Decomposition’s validity' do
      qu  = Blanket[B[0,1,2,3,4,5,17], B[6,7,8,9,10,11,12,13,14,15,16,18,19]]
      qv  = Blanket[B[0,1,2,17,19], B[3,6,7,8,9,10,11,12], B[4,5,18], B[13,14,15,16]]
      g   = Blanket[B[0,1,4,6,17,18,19], B[2,7,9,11], B[3,5,8,10,12], B[13,14,15,16]]
      assert Decomposition.new(@fsm, Set[1,3], Set[0,2], qu, qv, g).valid?
      refute Decomposition.new(@fsm, Set[1,3], Set[0,2], qv, qu, g).valid?
      refute Decomposition.new(@fsm, Set[1,3], Set[0,2], qv, qv, g).valid?
    end
  end
end end
