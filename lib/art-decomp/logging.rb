require 'logger'
require 'rcapture'

module ArtDecomp class Logging
  def initialize level, opts
    self.logger  = Logger.new $stdout
    logger.level = Logger::UNKNOWN

    executable = opts.fetch :executable
    executable.class_eval { include RCapture::Interceptable }
    executable.capture_pre methods: :run do |point|
      logger.unknown 'Executable#run'
    end
  end

  private

  attr_accessor :logger
end end
