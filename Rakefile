# encoding: UTF-8

require 'rake/testtask'

Rake::TestTask.new do |task|
  task.test_files = FileList['test/**/*_spec.rb']
end

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
