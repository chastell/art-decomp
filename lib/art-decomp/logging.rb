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

    Executable.class_eval { include RCapture::Interceptable }

    Executable.capture_post :methods => :run do |point|
      secs = (Time.now - @start).to_i
      @best = point.sender.best
      @log.info "took #{secs / 60 / 60}h #{secs / 60 % 60}m #{secs % 60}s"
    end

    Executable.capture_pre :methods => :decompositions do |point|
      @best = point.sender.best
      @path = point.args[2][point.sender.dir.size+1..-1]
      @log.info "#{point.args[0].stats} with #{point.sender.gens}"
    end

    UVGenerator.constants.map { |c| eval("UVGenerator::#{c}") }.each do |uv_gen|
      uv_gen.class_eval { include RCapture::Interceptable }
      uv_gen.capture_pre :methods => :uv_pairs do |point|
        @log.info "UV with #{point.sender.class.to_s.split('::').last}"
      end
    end

    QuGenerator.constants.map { |c| eval("QuGenerator::#{c}") }.each do |qu_gen|
      qu_gen.class_eval { include RCapture::Interceptable }
      qu_gen.capture_pre :methods => :blankets do |point|
        @log.info "#{point.args[1].sort.join(' ').ljust 10} #{point.args[2].sort.join(' ').ljust 10} with #{point.sender.class.to_s.split('::').last}"
      end
    end
  end

  def off
    # FIXME: if methods can be uncaptured, do that and close @log
    @log = Logger.new '/dev/null'
  end

end

end end
