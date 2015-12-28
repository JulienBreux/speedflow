require 'commander'
require 'colorize'

module Speedflow
  class Command
    include Commander::Methods

    attr_accessor :project_path

    def run(project_path)
      self.project_path = project_path

      specs = Gem.loaded_specs['speedflow']

      program :name, specs.name.to_s
      program :version, specs.version.to_s
      program :description, specs.description.to_s
      program :help, 'Author', specs.authors[0]+" "+specs.email[0]

      global_option('--verbose') { $verbose = true }

      # Command - Init
      command :init do |c|
        configuration = Speedflow::Configuration
        configuration.project_path = project_path

        c.syntax = specs.name.to_s+' init'
        c.description = 'Initilize your project flow'
        c.option '-f', '--force', 'Force file creation'
        c.action do |args, options|
          if !configuration.exists? || options.force
            if agree("Do you want to use a version control system? (y/n)")
              configuration.settings[:vcs] = {
                :adapter => choose("Choose an adapter?", :git, :mercurial).to_s
              }
              say("Ok for the VCS".colorize(:green))
            end
            if agree("Do you want to use a service control manager? (y/n)")
              configuration.settings[:scm] = {
                :adapter => choose("Choose an adapter?", :github, :bitbucket).to_s
              }
              say("Ok for the SCM".colorize(:green))
            end
            if agree("Do you want to use a project manager? (y/n)")
              configuration.settings[:pm] = {
                :adapter => choose("Choose an adapter?", :jira, :trello).to_s
              }
              say("Ok for the PM".colorize(:green))
            end

            configuration.save!

            say "Initialized speedflow in #{@project_path}"
          else
            say "Speedflow already exists in #{@project_path}"
          end
        end
      end
      alias_command :i, :init

      run!
    end
  end
end
