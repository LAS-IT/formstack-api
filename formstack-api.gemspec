# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'formstack/api/version'

Gem::Specification.new do |spec|
  spec.name          = "formstack-api"
  spec.version       = Formstack::Api::VERSION
  spec.authors       = ["Mauro Morales"]
  spec.email         = ["contact@mauromorales.com"]
  spec.summary       = %q{Formstack API V2 Ruby Wrapper.}
  spec.description   = %q{Formstack API V2 Ruby Wrapper.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
