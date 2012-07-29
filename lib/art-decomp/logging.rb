require 'logger'
require 'rcapture'

module ArtDecomp class Logging
  def initialize level, opts
    self.logger  = Logger.new $stdout
    logger.level = Logger::UNKNOWN

    classes[:executable] = opts.fetch :executable

    log_executable
  end

  private

  def classes
    @classes ||= {}
  end

  def log_executable
    classes[:executable].class_eval { include RCapture::Interceptable }
    classes[:executable].capture_pre methods: :run do |point|
      logger.unknown 'Executable#run'
    end
  end

  attr_accessor :logger
end end
