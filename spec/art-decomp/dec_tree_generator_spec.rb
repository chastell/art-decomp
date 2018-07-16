require_relative '../spec_helper'

module ArtDecomp
  describe DecTreeGenerator do
    describe '#dectrees' do
      it 'yields subsequent DecTrees' do
        archs  = Object.new
        gens   = Object.new
        fsm    = Object.new
        fsm1   = Object.new
        fsm11  = Object.new
        dec1   = OpenStruct.new(h: fsm1)
        dec11  = OpenStruct.new(h: fsm11)
        dec111 = Object.new
        dec12  = Object.new

        def dec1.final?(*_)
          false
        end

        def dec11.final?(*_)
          false
        end

        def dec111.final?(*_)
          true
        end

        def dec12.final?(*_)
          true
        end

        decomposer1   = MiniTest::Mock.new.expect :decompositions, [dec1]
        decomposer11  = MiniTest::Mock.new.expect :decompositions, [dec11, dec12]
        decomposer111 = MiniTest::Mock.new.expect :decompositions, [dec111]

        dec_class = MiniTest::Mock.new
        dec_class.expect :new, decomposer1,   [{ archs: archs, fsm: fsm,   gens: gens }]
        dec_class.expect :new, decomposer11,  [{ archs: archs, fsm: fsm1,  gens: gens }]
        dec_class.expect :new, decomposer111, [{ archs: archs, fsm: fsm11, gens: gens }]

        dt_gen = DecTreeGenerator.new archs: archs, fsm: fsm, gens: gens, decomposer_class: dec_class
        dt_gen.dectrees.to_a.must_equal [
          DecTree.new(archs, [dec1, dec11, dec111]),
          DecTree.new(archs, [dec1, dec12]),
        ]
      end
    end
  end
end
