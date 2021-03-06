require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/pride'

require 'pathname'
require 'tempfile'

require_relative '../lib/art-decomp'

include ArtDecomp # rubocop:disable MixinUsage

def qu_blankets(opts)
  fsm = MiniTest::Mock.new
  fsm.expect :beta_f, opts[:beta_f]
  fsm.expect :beta_q, opts[:beta_q]
  fsm.expect :beta_x, opts[:beta_x], [Set]
  opts[:generator].blankets fsm, Set[0], Set[1]
end

def verify_qv_blankets(generator, pairs) # rubocop:disable AbcSize, MethodLength
  beta_f  = MiniTest::Mock.new
  5.times do
    beta_f.expect :seps, Set[Sep[1,2], Sep[1,3], Sep[1,6], Sep[2,6],
                             Sep[3,4], Sep[3,6], Sep[4,5], Sep[5,6]]
  end
  beta_u  = Blanket[]
  beta_v  = Blanket[B[1,3,5], B[2,4,6]]
  beta_qu = Blanket[]

  fsm = MiniTest::Mock.new
  3.times { fsm.expect :beta_f, beta_f }
  3.times { fsm.expect :beta_q, Blanket[B[1,2], B[3,4], B[5,6]] }
  def fsm.beta_x(set)
    case
    when set == Set[0] then Blanket[]
    when set == Set[1] then Blanket[B[1,3,5], B[2,4,6]]
    end
  end

  blankets = generator.blankets(fsm, Set[0], Set[1], beta_qu).to_a

  blankets.must_equal pairs
  blankets.each do |beta_qv, beta_g|
    assert beta_f.seps.subset? beta_u.seps + beta_qu.seps + beta_g.seps
    assert beta_g.seps.subset? beta_v.seps + beta_qv.seps
  end
end
