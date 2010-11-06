Gem::Specification.new do |gem|
  gem.name     = 'art-decomp'
  gem.version  = '0.4.0'
  gem.summary  = 'art décomp: an FSM → FPGA decomposer'
  gem.homepage = 'http://github.com/chastell/art-decomp'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'p.szotkowski@tele.pw.edu.pl'

  gem.files       = `git ls-files -z`.split "\0"
  gem.files      -= Dir['kiss/**/*']
  gem.executables = Dir['bin/*'].map { |d| d.split '/' }.map &:last
  gem.test_files  = Dir['spec/**/*.rb']

  gem.add_dependency 'rcapture'
  gem.add_dependency 'trollop'
  gem.add_development_dependency 'diff-lcs'
  gem.add_development_dependency 'rcov'
  gem.add_development_dependency 'rspec'
end
