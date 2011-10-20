# encoding: UTF-8

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

desc 'Run art décomp console'
task :console do
  require 'irb'
  require_relative 'lib/art-decomp'
  include ArtDecomp
  ARGV.clear
  IRB.start
end

task default: :spec
