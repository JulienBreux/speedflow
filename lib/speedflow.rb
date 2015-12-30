require "active_support/core_ext/string"
require "active_support/core_ext/hash"
require "speedflow/version"
require "speedflow/configuration"
require "speedflow/configurable"
require "speedflow/command"
require "speedflow/pm"
require "speedflow/scm"
require "speedflow/vcs"

# Commands
Dir[File.dirname(__FILE__) + "/speedflow/commands/*.rb"].each {|file| require file }

# Adapters
Dir[File.dirname(__FILE__) + "/speedflow/adapters/**/*.rb"].each {|file| require file }
