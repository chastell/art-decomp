# encoding: UTF-8

require 'logger'
require 'rcapture'

module ArtDecomp class Logging

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
    # FIXME: if methods can be uncaptured, do that and close @@log
    @@log = Logger.new '/dev/null'
  end


  def self.apply!
    Executable.class_eval { include RCapture::Interceptable }

    Executable.capture_post :methods => :run do |point|
      secs = (Time.now - @@start).to_i
      @@log.info "#{point.sender.best ? "final best decomposition: #{point.sender.best} cells" : 'no final decomposition'}; done in #{secs}s (#{secs / 60 / 60}h #{secs / 60 % 60}m #{secs % 60}s)"
    end

    Executable.capture_pre :methods => :decompositions do |point|
      @@indent = '  ' * (point.sender.iters - point.args[1])
      path     = point.args[2][point.sender.dir.size+1..-1]
      archs    = point.sender.archs.map(&:to_s).sort.reverse.join '+'
      @@log.info "#{@@indent}FSM #{point.args[0].stats} → #{archs} (#{path}) with #{point.sender.gens} – #{point.sender.best ? "best so far: #{point.sender.best} cells" : 'no decomposition so far'}"
    end

    UVGenerator.constants.map { |c| eval("UVGenerator::#{c}") }.each do |uv_gen|
      uv_gen.class_eval { include RCapture::Interceptable }
      uv_gen.capture_pre :methods => :uv_pairs do |point|
        @@log.info "#{@@indent}  UV with #{point.sender.class.to_s.split('::').last}"
      end
    end

    QuGenerator.constants.map { |c| eval("QuGenerator::#{c}") }.each do |qu_gen|
      qu_gen.class_eval { include RCapture::Interceptable }
      qu_gen.capture_pre :methods => :blankets do |point|
        @@log.info "#{@@indent}    U = #{point.args[1].sort.inspect}, V = #{point.args[2].sort.inspect}, Qu with #{point.sender.class.to_s.split('::').last}"
      end
    end

    QvGenerator.constants.map { |c| eval("QvGenerator::#{c}") }.each do |qv_gen|
      qv_gen.class_eval { include RCapture::Interceptable }
      qv_gen.capture_pre :methods => :blankets do |point|
        @@log.debug "#{@@indent}      |Qu| = #{point.args[3].size}, Qv+G with #{point.sender.class.to_s.split('::').last}"
      end
    end
  end

end end
