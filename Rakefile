require 'bundler/setup'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new :spec do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
  task.warning    = true
end

RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end

desc 'Run art décomp console'
task :console do
  require 'irb'
  require_relative 'lib/art-decomp'
  include ArtDecomp
  ARGV.clear
  IRB.start
end

task default: %i[spec rubocop]
