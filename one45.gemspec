# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'one45/version'

Gem::Specification.new do |spec|
  spec.name          = "one45"
  spec.version       = One45::VERSION
  spec.authors       = ["Olivier"]
  spec.email         = ["osimart@uottawa.ca", "olivier@yafoy.com"]

  spec.summary       = "Ruby bindings for the one45 API"
  spec.description   = "Interact with one45 key endpoints"
  spec.homepage      = "https://github.com/uOttawaMedtech/one45-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rest-client', '~> 1.7'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  # TESTS
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.22"
end
