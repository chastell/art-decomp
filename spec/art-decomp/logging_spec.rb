# encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../lib/art-decomp/logging'

module ArtDecomp describe Logging do
  let(:executable) do
    Class.new do
      def archs
        Set[Arch[5,1], Arch[4,2]]
      end

      def fsm
        FSM.from_kiss 'spec/fixtures/fsm'
      end

      def name
        'fsm'
      end

      def run; end
    end
  end

  describe '.new' do
    it 'logs Executable#run starts' do
      capture_io do
        Logging.new 'unknown', executable: executable
        executable.new.run
      end.first.must_include 'decomposing fsm: 4/2+10s → 5/1 + 4/2'
    end
  end
end end
