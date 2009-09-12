require 'gazer'
require 'logger'

module ArtDecomp class Logging < Gazer::Aspect::Base

  def self.log= log
    @@log = Logger.new log
    @@log.formatter = proc { |sev, date, name, msg| "#{date} #{msg}\n" }
    apply!
  end

  def self.off
    @@log = Logger.new '/dev/null'
    Decomposer.unadvise_all
  end

  before Decomposer => :new do |point|
    @@log.info "decomposing into #{point.args.first[:archs].map(&:to_s).sort.reverse.join '+'} archs"
  end

end end
