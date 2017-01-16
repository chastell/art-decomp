# encoding: UTF-8

Gem::Specification.new do |gem|
  gem.name     = 'art-decomp'
  gem.version  = '0.4.0'
  gem.summary  = 'art décomp: an FSM → FPGA decomposer'
  gem.homepage = 'http://github.com/chastell/art-decomp'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'p.szotkowski@tele.pw.edu.pl'

  gem.files       = `git ls-files -z`.split "\0"
  gem.files      -= Dir['kiss/**/*']
  gem.executables = gem.files.grep(%r{^bin/}).map { |path| File.basename path }
  gem.test_files  = gem.files.grep %r{^spec/.*\.rb$}

  gem.add_dependency 'rcapture', '~> 1.0'
  gem.add_dependency 'trollop',  '~> 2.0'

  gem.add_development_dependency 'minitest', '~> 5.0'
end
