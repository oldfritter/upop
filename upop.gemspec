# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upop/version'

Gem::Specification.new do |spec|
  spec.name          = "upop"
  spec.version       = Upop::VERSION
  spec.authors       = ["oldfritter"]
  spec.email         = ["leon.zcf@gmail.com"]
  spec.summary       = %q{An simple upop gem}
  spec.description   = %q{An simple upop gem}
  spec.homepage      = "https://github.com/oldfritter/upop.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
