require_relative '../spec_helper'

module ArtDecomp # rubocop:disable ModuleLength
  describe SepMatrix do
    let(:sep_01) do
      SepMatrix.new [
        0b10,
        0b01,
      ]
    end
    let(:sep_01_02) do
      SepMatrix.new [
        0b110,
        0b001,
        0b001,
      ]
    end
    let(:sep_01_02_03_04_12_13_14) do
      SepMatrix.new [
        0b11110,
        0b11101,
        0b00011,
        0b00011,
        0b00011,
      ]
    end
    let(:sep_01_02_03_04_12_13_14_23_24_34) do
      SepMatrix.new [
        0b11110,
        0b11101,
        0b11011,
        0b10111,
        0b01111,
      ]
    end
    let(:sep_01_02_03_04_13_14) do
      SepMatrix.new [
        0b11110,
        0b11001,
        0b00001,
        0b00011,
        0b00011,
      ]
    end
    let(:sep_01_02_12) do
      SepMatrix.new [
        0b110,
        0b101,
        0b011,
      ]
    end
    let(:sep_01_12) do
      SepMatrix.new [
        0b010,
        0b101,
        0b010,
      ]
    end
    let(:sep_01_23) do
      SepMatrix.new [
        0b0010,
        0b0001,
        0b1000,
        0b0100,
      ]
    end
    let(:sep_01_45) do
      SepMatrix.new [
        0b000010,
        0b000001,
        0b000000,
        0b000000,
        0b100000,
        0b010000,
      ]
    end
    let(:sep_02) do
      SepMatrix.new [
        0b100,
        0b000,
        0b001,
      ]
    end
    let(:sep_02_03_12_13) do
      SepMatrix.new [
        0b1100,
        0b1100,
        0b0011,
        0b0011,
      ]
    end
    let(:sep_02_03_12_13_23) do
      SepMatrix.new [
        0b1100,
        0b1100,
        0b1011,
        0b0111,
      ]
    end
    let(:sep_03) do
      SepMatrix.new [
        0b1000,
        0b0000,
        0b0000,
        0b0001,
      ]
    end
    let(:sep_03_04_13_14) do
      SepMatrix.new [
        0b11000,
        0b11000,
        0b00000,
        0b00011,
        0b00011,
      ]
    end
    let(:sep_04) do
      SepMatrix.new [
        0b10000,
        0b00000,
        0b00000,
        0b00000,
        0b00001,
      ]
    end
    let(:sep_12) do
      SepMatrix.new [
        0b000,
        0b100,
        0b010,
      ]
    end
    let(:sep_empty) { SepMatrix.new [] }

    describe '.from_blanket' do
      it 'builds upon separations provided by a Blanket' do
        SepMatrix.from_blanket(Blanket[]).must_equal     sep_empty
        SepMatrix.from_blanket(Blanket[B[0]]).must_equal sep_empty
        SepMatrix.from_blanket(Blanket[B[1]]).must_equal sep_empty
        Blanket[B[1], B[2]].sep_matrix.must_equal        SepMatrix.new [0b000, 0b100, 0b010]
        SepMatrix.from_blanket(Blanket[B[0], B[1,2], B[2,3,4]]).must_equal sep_01_02_03_04_13_14
      end
    end

    describe '.from_seps' do
      it 'builds from the provided Enumerable of Seps' do
        SepMatrix.from_seps([]).must_equal sep_empty
        SepMatrix.from_seps([Sep[0,1]]).must_equal sep_01
        SepMatrix.from_seps([Sep[0,1],Sep[0,2],Sep[0,3],Sep[0,4],Sep[1,2],
                             Sep[1,3],Sep[1,4]]).must_equal sep_01_02_03_04_12_13_14
        SepMatrix.from_seps([Sep[1,2]]).must_equal sep_12
      end
    end

    describe '.new' do
      it 'cleans-up the matrix when building' do
        SepMatrix.new([]).must_equal                    sep_empty
        SepMatrix.new([0b00, 0b00]).must_equal          sep_empty
        SepMatrix.new([0b010, 0b001, 0b000]).must_equal SepMatrix.new [0b10, 0b01]
      end
    end

    describe '#==' do
      it 'compares SepMatrices properly' do
        SepMatrix.new([]).must_equal           sep_empty
        SepMatrix.new([0b0]).must_equal        sep_empty
        SepMatrix.new([0b10, 0b01]).must_equal SepMatrix.new [0b10, 0b01]
        SepMatrix.new([0b10, 0b01]).wont_equal SepMatrix.new [0b10, 0b10]
      end
    end

    describe '#&' do
      it 'ANDs the SepMatrices together' do
        (sep_01_12 & sep_01_02).must_equal sep_01
        (sep_01_02_03_04_13_14 & sep_01_02_12).must_equal sep_01_02
        (sep_01_02_12 & sep_01_02_03_04_13_14).must_equal sep_01_02
      end
    end

    describe '#+' do
      it 'sums the SepMatrices together' do
        (sep_01_12 + sep_01_02).must_equal sep_01_02_12
        (sep_01_02_03_04_13_14 + sep_01_02_12).must_equal sep_01_02_03_04_12_13_14
        (sep_01_02_12 + sep_01_02_03_04_13_14).must_equal sep_01_02_03_04_12_13_14
      end
    end

    describe '#-' do
      it 'subtracts the second SepMatrix from the first' do
        (sep_01_12 - sep_01).must_equal    sep_12
        (sep_01_02 - sep_01).must_equal    sep_02
        (sep_01_12 - sep_01_02).must_equal sep_12
        (sep_01_02 - sep_01_12).must_equal sep_02
        (sep_01_02_03_04_13_14 - sep_01_02_12).must_equal sep_03_04_13_14
        (sep_01_02_12 - sep_01_02_03_04_13_14).must_equal sep_12
      end
    end

    describe '#|' do
      it 'ORs the SepMatrices together' do
        (sep_01_12 | sep_01_02).must_equal sep_01_02_12
        (sep_01_02_03_04_13_14 | sep_01_02_12).must_equal sep_01_02_03_04_12_13_14
        (sep_01_02_12 | sep_01_02_03_04_13_14).must_equal sep_01_02_03_04_12_13_14
      end
    end

    describe '#conflicts_of' do
      it 'returns a block with conflicts for the given block' do
        sep_01_12.conflicts_of(B[0]).must_equal     B[1]
        sep_01_12.conflicts_of(B[1]).must_equal     B[0,2]
        sep_01_12.conflicts_of(B[2]).must_equal     B[1]
        sep_01_12.conflicts_of(B[0,1]).must_equal   B[0,1,2]
        sep_01_12.conflicts_of(B[0,2]).must_equal   B[1]
        sep_01_12.conflicts_of(B[1,2]).must_equal   B[0,1,2]
        sep_01_12.conflicts_of(B[0,1,2]).must_equal B[0,1,2]
        sep_empty.conflicts_of(B[0]).must_equal     B[]
      end
    end

    describe '#empty?' do
      it 'is a predicate whether the SepMatrix is empty' do
        SepMatrix.new([]).must_be           :empty?
        SepMatrix.new([0b0]).must_be        :empty?
        SepMatrix.new([0b00, 0b00]).must_be :empty?
        SepMatrix.new([0b10, 0b01]).wont_be :empty?
      end
    end

    describe '#r_adm' do
      it 'returns the given block’s r-admissibility' do
        b = B[0,1,2,3]
        sep_04.r_adm(b).must_equal 0
        sep_03.r_adm(b).must_equal 1
        sep_01.r_adm(b).must_equal 1
        sep_01_45.r_adm(b).must_equal 1
        sep_01_23.r_adm(b).must_equal 1
        sep_02_03_12_13.r_adm(b).must_equal 1
        sep_02_03_12_13_23.r_adm(b).must_equal 2
        sep_01_02_03_04_12_13_14_23_24_34.r_adm(b).must_equal 2
      end
    end

    describe '#matrix_size' do
      it 'returns the internal size of the matrix' do
        SepMatrix.new([]).matrix_size.must_equal    0
        SepMatrix.new([0b0]).matrix_size.must_equal 0
        sep_01.matrix_size.must_equal               2
      end
    end

    describe '#size' do
      it 'returns the number of separations' do
        SepMatrix.new([]).size.must_equal           0
        SepMatrix.new([0b00, 0b00]).size.must_equal 0
        sep_01.size.must_equal                      1
        sep_01_02.size.must_equal                   2
        sep_01_02_03_04_12_13_14.size.must_equal    7
      end
    end

    describe '#subset?' do
      it 'is a predicate whether a SepMatrix is a subset of another' do
        assert sep_01.subset? sep_01
        assert sep_01.subset? sep_01_02
        assert sep_01_02.subset? sep_01_02_03_04_12_13_14
        refute sep_01_02.subset? sep_01
        refute sep_01_02.subset? sep_01_12
      end
    end

    describe '#superset?' do
      it 'is a predicate whether a SepMatrix is a superset of another' do
        assert sep_01.superset? sep_01
        assert sep_01_02.superset? sep_01
        assert sep_01_02_03_04_12_13_14.superset? sep_01_02
        refute sep_01.superset? sep_01_02
        refute sep_01_12.superset? sep_01_02
      end
    end
  end
end
