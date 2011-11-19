# encoding: UTF-8

require 'rake/testtask'

Rake::TestTask.new :spec do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
end

desc 'Run art décomp console'
task :console do
  require 'irb'
  require_relative 'lib/art-decomp'
  include ArtDecomp
  ARGV.clear
  IRB.start
end

task default: :spec
