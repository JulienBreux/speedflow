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

      # Command - Init
      command :init do |c|
        c.syntax = specs.name.to_s+' init'
        c.description = 'Initialize your project flow'
        c.option '-f', '--force', 'Force file creation'
        c.action(Speedflow::Commands::Init.new(specs, project_path, c))
      end
      alias_command :i, :init

      # Command - Default
      command :default do |c|
        c.action(Speedflow::Commands::Default.new(specs, project_path, c))
      end
      default_command :default

      run!
    end
  end
end
