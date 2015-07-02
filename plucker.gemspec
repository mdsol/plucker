# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plucker/version'

Gem::Specification.new do |spec|
  spec.name          = "plucker"
  spec.version       = Plucker::VERSION
  spec.authors       = ["George Ding"]
  spec.email         = ["gd264@cornell.edu"]

  spec.summary       = %q{A regexp matching search that simplifies testing code modifications in cucumber testing environment.}
  spec.description   = %q{Instead of having to guess and brute search, plucker helps you find the best testing option for your modified code in your environment in various easy to understand formats.}
  spec.homepage      = "https://www.george-ding.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["plucker"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "to_regexp", "~> 0.2.1"
end
