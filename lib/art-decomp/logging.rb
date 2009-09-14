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
    @@indent = 0
    apply!
  end

  def self.off
    # FIXME: if instances can be unadvised, do that and close @@log
    @@log = Logger.new '/dev/null'
  end

  after instances_of(Executable) => :run do |point|
    @@log.info "final best decomposition: #{point.object.best} cells"
  end

  before instances_of(Executable) => :decompositions do |point|
    @@indent = point.object.depth - point.args[1]
    path     = point.args[2][point.object.dir.size+1..-1]
    archs    = point.object.archs.map(&:to_s).sort.reverse.join '+'
    @@log.info '  ' * @@indent + "FSM #{point.args[0].stats} → #{archs} (#{path}) with #{point.object.gens} – best so far: #{point.object.best} cells"
  end

  before instances_of(UVGenerator.constants.map { |c| eval("UVGenerator::#{c}") }) => :uv_pairs do |point|
    @@log.info '  ' * (@@indent + 1) + "UV with #{point.object.class.to_s.split('::').last}"
  end

  before instances_of(QuGenerator.constants.map { |c| eval("QuGenerator::#{c}") }) => :blankets do |point|
    @@log.info '  ' * (@@indent + 2) + "U = #{point.args[1]}, V = #{point.args[2]}, Qu with #{point.object.class.to_s.split('::').last}"
  end

  before instances_of(QvGenerator.constants.map { |c| eval("QvGenerator::#{c}") }) => :blankets do |point|
    @@log.debug '  ' * (@@indent + 3) + "|Qu| = #{point.args[3].size}, Qv+G with #{point.object.class.to_s.split('::').last}"
  end

end end
