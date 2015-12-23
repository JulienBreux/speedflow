require "bundler/setup"
require 'simplecov'
require 'simplecov-json'
require 'simplecov-rcov'

Bundler.setup

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::JSONFormatter,
  SimpleCov::Formatter::RcovFormatter
]
SimpleCov.start do
  add_filter 'spec'
end

require File.expand_path('../../lib/speedflow', __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
