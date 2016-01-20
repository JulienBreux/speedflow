# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'speedflow/version'

Gem::Specification.new do |spec|
  spec.name               = 'speedflow'
  spec.version            = Speedflow::VERSION
  spec.authors            = ['Julien Breux']
  spec.email              = ['julien.breux@gmail.com']

  spec.summary            = 'Speedflow help you to boost your workflow.'
  spec.description        = 'Speedflow is a glue between some tools ' \
                            '(Eg: Jira, Git-Flow, GitHub and more...)'
  spec.homepage           = 'https://JulienBreux.github.io/speedflow'
  spec.license            = 'MIT'

  spec.files              = Dir[
    'LICENSE', 'readme.md', 'version', 'lib/**/*', 'bin/**/*', 'test/**/*'
  ]
  spec.test_files         = spec.files.grep(/^test/)
  spec.require_paths      = ['lib']
  spec.bindir             = 'bin'
  spec.executables        = %w('speedflow', 'sf')
  spec.default_executable = ['speedflow']

  # Core dependencies
  spec.add_dependency 'require_all', '~> 1.3'
  spec.add_dependency 'commander'
  spec.add_dependency 'colorize'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'recursive-open-struct', '~> 1.0'

  # Adapters dependencies
  spec.add_dependency 'git', '~> 1.2'
  spec.add_dependency 'github_api', '~> 0.13.1'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'simplecov'
end
