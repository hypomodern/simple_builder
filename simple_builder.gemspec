# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_builder'

Gem::Specification.new do |spec|
  spec.name          = "simple_builder"
  spec.version       = SimpleBuilder::VERSION
  spec.authors       = ["Matt Wilson"]
  spec.email         = ["mhw@hypomodern.com"]
  spec.summary       = %q{Simple, PORO object builder/updater service}
  spec.description   = %q{I got tired of reinventing a basic builder service in every project.}
  spec.homepage      = "https://github.com/hypomodern/simple_builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.3"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
end
