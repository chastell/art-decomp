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
    @@log.info "decomposing a #{point.args.first[:fsm].stats} FSM into #{point.args.first[:archs].map(&:to_s).sort.reverse.join '+'} cells"
  end

  before instances_of(QuGenerator.constants.map { |c| eval("QuGenerator::#{c}") }) => :blankets do |point|
    @@log.info "U = #{point.args[1]}, V = #{point.args[2]}"
  end

end end
