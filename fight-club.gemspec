# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fight_club/version'

Gem::Specification.new do |spec|
  spec.name          = "fight_club"
  spec.version       = FightClub::VERSION
  spec.authors       = ["Tim Minkov"]
  spec.email         = ["timothyminkov@gmail.com"]
  spec.summary       = %q{Finds conflicts against open pull requests}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "octokit"
  spec.add_runtime_dependency "httparty"
end
