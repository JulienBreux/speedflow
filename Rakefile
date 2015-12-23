require "bundler/gem_tasks"
require "rake/testtask"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |task|
  task.fail_on_error = false
end

task :default => :spec
