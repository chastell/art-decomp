# encoding: UTF-8

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new :cov do |t|
  t.rcov      = true
  t.rcov_opts = ['--exclude', 'spec']
  t.spec_opts = ['--options', 'spec/spec.opts']
end

Spec::Rake::SpecTask.new :spec do |t|
  t.spec_opts = ['--options', 'spec/spec.opts']
end

namespace :spec do
  FileList['spec/**/*_spec.rb'].each do |file|
    spec = file.split('/').last[0...-8]
    desc "Run the #{spec} spec"
    Spec::Rake::SpecTask.new spec do |t|
      t.spec_files = [file]
      t.spec_opts  = ['--options', 'spec/spec.opts']
    end
  end
end

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.authors  = ['Piotr Szotkowski']
  gem.email    = 'p.szotkowski@tele.pw.edu.pl'
  gem.homepage = 'http://github.com/chastell/art-decomp'
  gem.name     = 'art-decomp'
  gem.summary  = 'art décomp: an FSM → FPGA decomposer'

  gem.files.exclude 'kiss/**/*'

  gem.add_dependency 'teejayvanslyke-gazer'
  gem.add_dependency 'trollop'

  gem.add_development_dependency 'diff-lcs'
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'rcov'
  gem.add_development_dependency 'rspec'
end

Jeweler::GemcutterTasks.new
