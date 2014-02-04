require File.expand_path('../lib/subtitle_download/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'subtitle_download'
  gem.version       = SubtitleDownload::VERSION
  gem.summary       = %q{Automatically download English subtitles}
  gem.description   = %q{Download English subtitles automatically on file creation}
  gem.license       = 'MIT'
  gem.authors       = ['Tom van Leeuwen']
  gem.email         = 'tom@vleeuwen.eu'
  gem.homepage      = 'https://rubygems.org/gems/subtitle_download'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.5.2'
  gem.add_development_dependency 'rake', '~> 10.1.1'
  #gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 2.14.1'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'

  gem.add_dependency 'listen', '~> 2.0'
  gem.add_dependency 'nokogiri', '~> 1.6.1'
  gem.add_dependency 'rubyzip', '~> 1.1.0'
  gem.add_dependency 'wdm', '~> 0.1.0'
end
