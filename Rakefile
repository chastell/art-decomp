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
