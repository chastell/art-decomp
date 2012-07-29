# encoding: UTF-8

require 'logger'
require 'rcapture'

module ArtDecomp class Logging
  def initialize level, opts
    self.logger  = Logger.new $stdout
    logger.level = Logger::UNKNOWN

    classes[:executable] = opts.fetch :executable

    extend_classes
    log_executable
  end

  private

  def classes
    @classes ||= {}
  end

  def extend_classes
    classes[:executable].class_eval { include RCapture::Interceptable }
  end

  def log_executable
    classes[:executable].capture_pre methods: :run do |point|
      ex = point.sender
      logger.unknown "decomposing #{ex.name}: #{ex.fsm.stats} → #{ex.archs.sort.map(&:to_s).join ' + '}"
    end
  end

  attr_accessor :logger
end end
