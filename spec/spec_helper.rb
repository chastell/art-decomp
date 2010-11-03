require 'tempfile'
require 'tmpdir'

require './lib/art-decomp'

def rex string
  Regexp.new Regexp.escape(string)
end
