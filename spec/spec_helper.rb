gem 'minitest'
require 'minitest/autorun'

require 'pathname'
require 'tempfile'

require_relative '../lib/art-decomp'

def qu_blankets opts
  fsm = MiniTest::Mock.new
  fsm.expect :beta_f, opts[:beta_f]
  fsm.expect :beta_q, opts[:beta_q]
  fsm.expect :beta_x, opts[:beta_x], [Array]
  opts[:generator].blankets fsm, Set[0], Set[1]
end
