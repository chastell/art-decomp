# encoding: UTF-8

require 'logger'
require 'rcapture'

module ArtDecomp class Logging

class << self

  def level
    @log.level
  end

  def level= level
    @log.level = level
  end

  def log= log
    @start = Time.now
    @log = Logger.new log
    @log.level = Logger::INFO
    @log.formatter = proc { |sev, date, name, msg| "#{(Time.now - @start).ceil.to_s.rjust 6}s #{(@best.nil? ? '' : @best.to_s + 'c').rjust 4} ·#{(@path.nil? ? '' : '/' + @path).ljust 10} #{msg}\n" }
    add_logging
  end

  def off
    # FIXME: if methods can be uncaptured, do that and close @log
    @log = Logger.new '/dev/null'
  end

  private

  def add_logging
    uv_gens = UVGenerator.constants.map { |c| UVGenerator.const_get c }
    qu_gens = QuGenerator.constants.map { |c| QuGenerator.const_get c }

    (uv_gens + qu_gens + [Executable]).each { |c| c.class_eval { include RCapture::Interceptable } }

    Executable.capture_pre :methods => :decompositions do |point|
      @best = point.sender.best
      @path = point.args[2][point.sender.dir.size+1..-1]
      @log.info "#{point.args[0].stats} with #{point.sender.gens}"
    end

    uv_gens.each do |uv_gen|
      uv_gen.capture_pre :methods => :uv_pairs do |point|
        @log.debug "UV with #{point.sender.class.to_s.split('::').last}"
      end
    end

    qu_gens.each do |qu_gen|
      qu_gen.capture_pre :methods => :blankets do |point|
        @log.debug "#{point.args[1].sort.join(' ').ljust 10} #{point.args[2].sort.join(' ').ljust 10} with #{point.sender.class.to_s.split('::').last}"
      end
    end

    Executable.capture_post :methods => :run do |point|
      @best = point.sender.best
      secs  = (Time.now - @start).ceil
      @log.info "took #{secs / 60 / 60}h #{secs / 60 % 60}m #{secs % 60}s"
    end
  end

end

end end
