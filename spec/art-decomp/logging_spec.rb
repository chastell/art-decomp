require_relative '../spec_helper'
require_relative '../../lib/art-decomp/logging'

module ArtDecomp describe Logging do
  let(:executable) { Class.new { def run; end } }

  describe '.new' do
    it 'logs Executable#run starts' do
      capture_io do
        Logging.new 'unknown', executable: executable
        executable.new.run
      end.first.must_include 'Executable#run'
    end
  end
end end
