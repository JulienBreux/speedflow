require 'commander'
require 'colorize'

module Speedflow
  class Command
    include Commander::Methods

    def run(project_path)
      # Define program
      specs = Gem.loaded_specs['speedflow']

      program :name, specs.name.to_s
      program :version, specs.version.to_s
      program :description, specs.description.to_s
      program :help, 'Author', specs.authors[0]+" "+specs.email[0]

      # Configuration
      config = Speedflow::Configuration
      config.project_path = project_path

      # Command - New
      command :new do |c|
        c.syntax = specs.name.to_s+' new'
        c.description = 'New issue'
        c.option '-s', '--subject [STRING]', String, 'Subject'
        c.action(Speedflow::Commands::New.new(specs, project_path, c, config))
      end
      alias_command :n, :new

      # Command - Init
      command :init do |c|
        c.syntax = specs.name.to_s+' init'
        c.description = 'Initialize your project flow'
        c.option '-f', '--force', 'Force file creation'
        c.action(Speedflow::Commands::Init.new(specs, project_path, c, config))
      end
      alias_command :i, :init

      # Command - Default
      command :default do |c|
        c.action(Speedflow::Commands::Default.new(specs, project_path, c, config))
      end
      default_command :default

      run!
    end
  end
end
