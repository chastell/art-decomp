require_relative '../spec_helper'

module ArtDecomp # rubocop:disable ModuleLength
  describe Blanket do
    describe '.[]' do
      it 'instantiates Blanket Array-style' do
        Blanket[B[], B[0], B[1,2]].must_equal Blanket.new [B[1,2], B[0]]
      end
    end

    describe '.from_array' do
      it 'returns a Blanket created from an Array' do
        blanket = Blanket.from_array [:b, DontCare, :a, :c, :b, :a, :c]
        blanket.must_equal Blanket[B[0,1,4], B[1,2,5], B[1,3,6]]
      end
    end

    describe '.new' do
      it 'drops subset blocks' do
        Blanket[B[1], B[1,2]].must_equal   Blanket[B[1,2]]
        Blanket[B[1,2], B[2,3]].must_equal Blanket[B[1,2], B[2,3]]
        Blanket[B[1], B[2,3]].must_equal   Blanket[B[1], B[2,3]]
      end
    end

    describe '#*' do
      it 'returns the multiplication of self and another Blanket' do
        b1 = Blanket[B[1,2,3], B[4,5,6]]
        b2 = Blanket[B[1,2], B[3,4], B[5,6]]
        (b1 * b2).must_equal Blanket[B[1,2], B[3], B[4], B[5,6]]
      end
    end

    describe '#encoding' do
      it 'returns the Blanket’s ‘natural’ encoding, based on the provided subblock' do
        blanket = Blanket[B[0,1,2], B[1,2,3], B[2,3,4]]
        blanket.encoding(B[0,1,2]).must_equal '00'
        blanket.encoding(B[1,2,3]).must_equal '01'
        blanket.encoding(B[2,3,4]).must_equal '10'
        blanket.encoding(B[2]).must_equal     '--'
        -> { blanket.encoding B[1,2] }.must_raise AmbiguousEncodingQuery
      end
    end

    describe '#encodings' do
      it 'returns the Blanket’s ‘natural’ encodings in an Array' do
        blanket = Blanket[B[0,1,2], B[1,2,3], B[2,3,4]]
        blanket.encodings(B[0,1,2]).must_equal ['00']
        blanket.encodings(B[1,2,3]).must_equal ['01']
        blanket.encodings(B[2,3,4]).must_equal ['10']
        blanket.encodings(B[2]).must_equal     ['--']
        blanket.encodings(B[1,2]).must_equal   %w[00 01]
      end
    end

    describe '#eql?' do
      it 'allows Blankets to be used as Set elements' do
        assert Blanket[B[], B[0], B[1,2]].eql? Blanket.new [B[1,2], B[0]]
      end
    end

    describe '#hash' do
      it 'allows Blankets to be used as Set elements' do
        Blanket[B[], B[0], B[1,2]].hash.must_equal Blanket[B[1,2], B[0]].hash
      end
    end

    describe '#inspect' do
      it 'returns a self-instanting form' do
        Blanket[B[]].inspect.must_equal          'Blanket[]'
        Blanket[B[1,2], B[0]].inspect.must_equal 'Blanket[B[0], B[1,2]]'
      end
    end

    describe '#ints' do
      it 'exposes its internal, immutable ints variable' do
        Blanket[B[1,2], B[3,4]].ints.must_equal Set[B[3,4], B[1,2]]
        assert Blanket[B[1,2], B[3,4]].ints.frozen?
      end
    end

    describe '#pins' do
      it 'returns the number of required physical pins' do
        Blanket[B[]].pins.must_equal                                          0
        Blanket[B[1]].pins.must_equal                                         0
        Blanket[B[1,2]].pins.must_equal                                       0
        Blanket[B[1],B[2]].pins.must_equal                                    1
        Blanket[B[1],B[2],B[3]].pins.must_equal                               2
        Blanket[B[1,2],B[3,4],B[5,6],B[7]].pins.must_equal                    2
        Blanket[B[1],B[2],B[3],B[4],B[5]].pins.must_equal                     3
        Blanket[B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8]].pins.must_equal      3
        Blanket[B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9]].pins.must_equal 4
      end
    end

    describe '#sep_matrix' do
      it 'returns the related SepMatrix' do
        Blanket[].sep_matrix.must_equal                   SepMatrix.new [0b0]
        Blanket[B[0]].sep_matrix.must_equal               SepMatrix.new [0b0]
        Blanket[B[1]].sep_matrix.must_equal               SepMatrix.new [0b0]
        Blanket[B[1], B[2], B[]].sep_matrix
                                .must_equal SepMatrix.new [0b000, 0b100, 0b010]
        Blanket[B[1,2], B[3,4]].sep_matrix
                               .must_equal SepMatrix.new [0b00000, 0b11000,
                                                          0b11000, 0b00110,
                                                          0b00110]
        Blanket[B[1,2,3], B[2,3,4]].sep_matrix
                                   .must_equal SepMatrix.new [0b00000, 0b10000,
                                                              0b00000, 0b00000,
                                                              0b00010]
      end
    end

    describe '#seps' do
      it 'returns the provided/required separations' do
        Blanket[].seps.must_equal                   Set[]
        Blanket[B[1]].seps.must_equal               Set[]
        Blanket[B[1], B[2], B[]].seps.must_equal    Set[Sep[1,2]]
        Blanket[B[1,2], B[3,4]].seps.must_equal     Set[Sep[1,3], Sep[1,4],
                                                        Sep[2,3], Sep[2,4]]
        Blanket[B[1,2,3], B[2,3,4]].seps.must_equal Set[Sep[1,4]]
      end
    end

    describe '#size' do
      it 'returns the Blanket’s size' do
        Blanket[].size.must_equal                   0
        Blanket[B[1]].size.must_equal               1
        Blanket[B[1], B[2], B[]].size.must_equal    2
        Blanket[B[1,2,3], B[2,3,4]].size.must_equal 2
      end
    end

    describe '#to_s' do
      it 'returns a self-instanting form' do
        Blanket[B[]].to_s.must_equal          'Blanket[]'
        Blanket[B[1,2], B[0]].to_s.must_equal 'Blanket[B[0], B[1,2]]'
      end
    end
  end
end
