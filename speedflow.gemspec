# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'speedflow/version'

Gem::Specification.new do |spec|
  spec.name               = "speedflow"
  spec.version            = Speedflow::VERSION
  spec.authors            = ["Julien Breux"]
  spec.email              = ["julien.breux@gmail.com"]

  spec.summary            = "Speedflow help you to boost your workflow."
  spec.description        = "Speedflow is a glue between some tools (Eg: Jira, Git-Flow, GitHub and more...)"
  spec.homepage           = "https://JulienBreux.github.io/speedflow"
  spec.license            = "MIT"

  spec.files              = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files         = Dir["spec/**/*"]
  spec.require_paths      = ["lib"]
  spec.bindir             = "bin"
  spec.executables        = ["speedflow"]
  spec.default_executable = ["speedflow"]

  spec.add_dependency "trollop", "~> 2.1"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
