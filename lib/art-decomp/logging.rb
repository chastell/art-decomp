# encoding: UTF-8

require 'gazer'
require 'logger'

module ArtDecomp class Logging < Gazer::Aspect::Base

  def self.level= level
    @@log.level = level
  end

  def self.log= log
    @@log = Logger.new log
    @@log.level = Logger::INFO
    @@log.formatter = proc { |sev, date, name, msg| "#{date} #{msg}\n" }
    apply!
  end

  def self.off
    # FIXME: if instances can be unadvised, do that and close @@log
    @@log = Logger.new '/dev/null'
    Decomposer.unadvise_all
  end

  before Decomposer => :new do |point|
    @@log.info "FSM #{point.args.first[:fsm].stats} → #{point.args.first[:archs].map(&:to_s).sort.reverse.join '+'} cells"
  end

  before instances_of(UVGenerator.constants.map { |c| eval("UVGenerator::#{c}") }) => :uv_pairs do |point|
    @@log.info "  UV with #{point.object.class.to_s.split('::').last}"
  end

  before instances_of(QuGenerator.constants.map { |c| eval("QuGenerator::#{c}") }) => :blankets do |point|
    @@log.info "    U = #{point.args[1]}, V = #{point.args[2]}, Qu with #{point.object.class.to_s.split('::').last}"
  end

  before instances_of(QvGenerator.constants.map { |c| eval("QvGenerator::#{c}") }) => :blankets do |point|
    @@log.debug "      |Qu| = #{point.args[3].size}, Qv+G with #{point.object.class.to_s.split('::').last}"
  end

end end
