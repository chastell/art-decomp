# encoding: UTF-8

require 'logger'
require 'rcapture'

module ArtDecomp class Logging

  def self.level
    @log.level
  end

  def self.level= level
    @log.level = level
  end

  def self.log= log
    @start = Time.now
    @log = Logger.new log
    @log.level = Logger::INFO
    @log.formatter = proc do |sev, date, name, msg|
      secs = (Time.now - @start).ceil
      time = "#{secs / 60 / 60}h#{(secs / 60 % 60).to_s.rjust 2}m#{(secs % 60).to_s.rjust 2}s"
      best = @best.nil? ? '' : @best.to_s + 'c'
      path = @path.nil? ? '' : '/' + @path
      "#{time.rjust 10} #{best.rjust 4}  ·#{path.ljust 10} #{msg}\n"
    end
    add_logging
  end

  def self.off
    # FIXME: if methods can be uncaptured, do that and close @log
    @log = Logger.new '/dev/null'
  end

  private

  def self.add_logging
    uv_gens = UVGenerator.constants.map { |c| UVGenerator.const_get c }
    qu_gens = QuGenerator.constants.map { |c| QuGenerator.const_get c }

    (uv_gens + qu_gens + [Executable]).each { |c| c.class_eval { include RCapture::Interceptable } }

    Executable.capture_pre methods: :decompositions do |point|
      @best = point.sender.best
      @path = point.args[2][point.sender.dir.size+1..-1]
      @log.info "#{point.args[0].stats} with #{point.sender.gens}"
    end

    uv_gens.each do |uv_gen|
      uv_gen.capture_pre methods: :uv_pairs do |point|
        @uv_gen = uv_gen.to_s.split('::').last
      end
    end

    qu_gens.each do |qu_gen|
      qu_gen.capture_pre methods: :blankets do |point|
        @log.debug "#{point.args[1].sort.join(' ').ljust 10} #{point.args[2].sort.join(' ').ljust 10} via #{@uv_gen} with #{qu_gen.to_s.split('::').last}"
      end
    end

    Executable.capture_post methods: :run do |point|
      @best = point.sender.best
      @log.info "took #{(Time.now - @start).ceil}s"
    end
  end
end end
