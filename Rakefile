require "bundler/gem_tasks"

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = "{./spec/**/*_spec.rb}"
    task.fail_on_error = false
  end
rescue LoadError
end

task :default => :spec
task :test => :spec
