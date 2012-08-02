require_relative '../spec_helper'

module ArtDecomp describe DecTree do
  let(:dec_tree) { DecTree.new Set[], ['foo', 'bar'] }

  let(:dec1) do
    fsm = FSM.from_kiss 'spec/fixtures/bbara'
    u   = Set[2]
    v   = Set[0,1,3]
    qu  = Blanket[B[0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150], B[1,11,21,31,41,51,61,71,81,91,101,111,121,131,141,151], B[2,12,22,32,42,52,62,72,82,92,102,112,122,132,142,152], B[3,13,23,33,43,53,63,73,83,93,103,113,123,133,143,153], B[4,14,24,34,44,54,64,74,84,94,104,114,124,134,144,154], B[5,15,25,35,45,55,65,75,85,95,105,115,125,135,145,155], B[6,16,26,36,46,56,66,76,86,96,106,116,126,136,146,156], B[7,17,27,37,47,57,67,77,87,97,107,117,127,137,147,157], B[8,18,28,38,48,58,68,78,88,98,108,118,128,138,148,158], B[9,19,29,39,49,59,69,79,89,99,109,119,129,139,149,159]]
    qv  = Blanket[B[0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150], B[1,2,4,5,7,8,9,11,12,14,15,17,18,19,21,22,24,25,27,28,29,31,32,34,35,37,38,39,41,42,44,45,47,48,49,51,52,54,55,57,58,59,61,62,64,65,67,68,69,71,72,74,75,77,78,79,81,82,84,85,87,88,89,91,92,94,95,97,98,99,101,102,104,105,107,108,109,111,112,114,115,117,118,119,121,122,124,125,127,128,129,131,132,134,135,137,138,139,141,142,144,145,147,148,149,151,152,154,155,157,158,159], B[3,13,23,33,43,53,63,73,83,93,103,113,123,133,143,153], B[6,16,26,36,46,56,66,76,86,96,106,116,126,136,146,156]]
    g   = Blanket[B[0,3,6,10,20,23,26,30,40,43,46,51,52,53,54,55,57,58,59,60,63,66,71,72,73,74,75,77,78,79,80,83,86,96,100,103,106,116,120,123,126,131,132,133,134,135,137,138,139,140,143,146,151,152,153,154,155,157,158,159], B[1,2,4,5,7,8,9,21,22,24,25,27,28,29,41,42,44,45,47,48,49,61,62,64,65,67,68,69,81,82,84,85,87,88,89,101,102,104,105,107,108,109,121,122,124,125,127,128,129,141,142,144,145,147,148,149], B[11,12,13,14,15,16,17,18,19,31,32,33,34,35,36,37,38,39,90,110], B[50,56,70,76,91,92,93,94,95,97,98,99,111,112,113,114,115,117,118,119,130,136,150,156]]
    Decomposition.new fsm.expand_x(v), u, v, qu, qv, g
  end

  let(:dec2) do
    fsm = FSM.from_kiss 'spec/fixtures/bbara.dec.h'
    u   = Set[2]
    v   = Set[0,1]
    qu  = Blanket[B[0,1,7,9,10,11,17,19,20,22,23,24,25,29,33,34,40,41,42,46,50,51,52,56], B[2,3,4,5,6,8,12,13,14,15,16,18,21,26,27,28,30,31,32,35,36,37,38,39,43,44,45,47,48,49,53,54,55,57,58,59]]
    qv  = Blanket[B[0,2,10,12,24,27,33,35,41,44,51,54], B[1,3,11,13,25,28,34,36,42,45,52,55], B[4,9,14,19,22,29,30,37,46,47,56,57], B[5,15,31,38,48,58], B[6,16,32,39,49,59], B[7,8,17,18,20,21,23,26,40,43,50,53]]
    g   = Blanket[B[0,2,10,12], B[1,3,11,13], B[4,9,14,19,22], B[5,15], B[6,16], B[7,8,17,18,20,21], B[23,26], B[24,27,33,35], B[25,28,34,36], B[29,30,37], B[31,38], B[32,39], B[40,43,50,53], B[41,44,51,54], B[42,45,52,55], B[46,47,48,49,56,57,58,59]]
    Decomposition.new fsm.expand_x(v), u, v, qu, qv, g
  end

  describe '#==' do
    it 'verifies tree equality' do
      dec_tree.must_equal DecTree.new Set[], ['foo', 'bar']
      dec_tree.wont_equal DecTree.new Set[], ['bar', 'foo']
    end
  end

  describe '#<<' do
    it 'appends elements' do
      dec_tree << 'baz'
      dec_tree.must_equal DecTree.new Set[], ['foo', 'bar', 'baz']
    end
  end

  describe '#cells' do
    it 'returns the number of cells of target arch' do
      DecTree.new(Set[Arch[6,1], Arch[5,2]], [dec1, dec2]).cells.must_equal 11
      DecTree.new(Set[Arch[6,1]],            [dec1, dec2]).cells.must_equal 14
      DecTree.new(Set[Arch[5,2]],            [dec1, dec2]).cells.must_equal Infinity
    end
  end

  describe '#dup' do
    it 'makes a shallow copy' do
      copy = dec_tree.dup
      copy << 'baz'
      dec_tree.must_equal DecTree.new Set[], ['foo', 'bar']
    end
  end

  describe '#g_cells' do
    it 'returns the number of cells of target arch taken by G blocks' do
      DecTree.new(Set[Arch[6,1], Arch[5,2]], [dec1, dec2]).g_cells.must_equal 3
      DecTree.new(Set[Arch[6,1]],            [dec1, dec2]).g_cells.must_equal 6
    end
  end

  describe '#pop' do
    it 'drops elements' do
      dec_tree.pop
      dec_tree.must_equal DecTree.new Set[], ['foo']
    end
  end

  describe '#to_vhdl' do
    it 'returns VHDL representation' do
      dec_tree = DecTree.new Set[Arch[6,1], Arch[5,2]], [dec1, dec2]
      dec_tree.to_vhdl('bbara').must_equal File.read 'spec/fixtures/bbara.vhdl'
    end
  end
end end
