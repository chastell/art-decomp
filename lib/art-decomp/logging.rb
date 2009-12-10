# encoding: UTF-8

require 'gazer'
require 'logger'

module ArtDecomp class Logging < Gazer::Aspect::Base

  def self.level
    @@log.level
  end

  def self.level= level
    @@log.level = level
  end

  def self.log= log
    @@log = Logger.new log
    @@log.level = Logger::INFO
    @@log.formatter = proc { |sev, date, name, msg| "#{date} #{msg}\n" }
    @@indent = ''
    apply!
    @@start = Time.now
  end

  def self.off
    # FIXME: if instances can be unadvised, do that and close @@log
    @@log = Logger.new '/dev/null'
  end

  after instances_of(Executable) => :run do |point|
    secs = (Time.now - @@start).to_i
    @@log.info "#{point.object.best ? "final best decomposition: #{point.object.best} cells" : 'no final decomposition'}; done in #{secs}s (#{secs / 60 / 60}h#{secs / 60 % 60}m#{secs % 60}s)"
  end

  before instances_of(Executable) => :decompositions do |point|
    @@indent = '  ' * (point.object.iters - point.args[1])
    path     = point.args[2][point.object.dir.size+1..-1]
    archs    = point.object.archs.map(&:to_s).sort.reverse.join '+'
    @@log.info "#{@@indent}FSM #{point.args[0].stats} → #{archs} (#{path}) with #{point.object.gens} – #{point.object.best ? "best so far: #{point.object.best} cells" : 'no decomposition so far'}"
  end

  before instances_of(UVGenerator.constants.map { |c| eval("UVGenerator::#{c}") }) => :uv_pairs do |point|
    @@log.info "#{@@indent}  UV with #{point.object.class.to_s.split('::').last}"
  end

  before instances_of(QuGenerator.constants.map { |c| eval("QuGenerator::#{c}") }) => :blankets do |point|
    @@log.info "#{@@indent}    U = #{point.args[1].sort.inspect}, V = #{point.args[2].sort.inspect}, Qu with #{point.object.class.to_s.split('::').last}"
  end

  before instances_of(QvGenerator.constants.map { |c| eval("QvGenerator::#{c}") }) => :blankets do |point|
    @@log.debug "#{@@indent}      |Qu| = #{point.args[3].size}, Qv+G with #{point.object.class.to_s.split('::').last}"
  end

end end
