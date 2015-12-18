# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'speedflow/version'

Gem::Specification.new do |spec|
  spec.name          = "speedflow"
  spec.version       = Speedflow::VERSION
  spec.authors       = ["Julien Breux"]
  spec.email         = ["julien.breux@gmail.com"]

  spec.summary       = "Speedflow help you to boost your workflow."
  spec.description   = "Speedflow is a glue between some tools (Eg: Jira, Git-Flow, GitHub and more...)"
  spec.homepage      = "https://JulienBreux.github.io/speedflow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
