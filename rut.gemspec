# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rut/version'

Gem::Specification.new do |gem|
  gem.name          = "rut"
  gem.version       = Rut::VERSION
  gem.authors       = ["Tomas Skogberg"]
  gem.email         = ["tomas.skogberg@gmail.com"]
  gem.summary       = "Router Uptime (rut)"
  gem.description   = "Rut is a CLI script that'll show you your routers uptime."
  gem.homepage      = "https://github.com/tskogberg/rut"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('rake','~> 0.9.2')
  gem.add_dependency('methadone', '~>1.2.1')
  gem.add_dependency('snmp', '~>1.1.0')
end
