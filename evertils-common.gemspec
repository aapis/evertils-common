# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'evertils/common/version'

Gem::Specification.new do |spec|
  spec.name          = "evertils-common"
  spec.version       = Evertils::Common::VERSION
  spec.authors       = ["Ryan Priebe"]
  spec.email         = ["rpriebe@me.com"]

  spec.summary       = %q{EN (heart) CLI}
  spec.description   = %q{Evernote utilities for your CLI workflow}
  spec.homepage      = "http://rubygems.org/gems/evertils-common"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundle", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'mime-types'
  spec.add_runtime_dependency "evernote-thrift"
  spec.add_runtime_dependency "notifaction"
end
