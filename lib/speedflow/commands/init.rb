module Speedflow
  module Commands
    class Init < Speedflow::Commands::Abstract
      def call(args, options)
        configuration = Speedflow::Configuration
        configuration.project_path = @project_path

        if !configuration.exists? || options.force
          if agree("Do you want to use a version control system? (y/n)")
            configuration.settings[:vcs] = {
              :adapter => @command.choose("Choose an adapter?", :git, :mercurial).to_s
            }
            @command.say("Ok for the VCS".colorize(:green))
          end
          if agree("Do you want to use a service control manager? (y/n)")
            configuration.settings[:scm] = {
              :adapter => @command.choose("Choose an adapter?", :github, :bitbucket).to_s
            }
            @command.say("Ok for the SCM".colorize(:green))
          end
          if agree("Do you want to use a project manager? (y/n)")
            configuration.settings[:pm] = {
              :adapter => @command.choose("Choose an adapter?", :jira, :trello).to_s
            }
            @command.say("Ok for the PM".colorize(:green))
          end

          configuration.save!

          @command.say("Initialized speedflow in #{@project_path}")
        else
          @command.say("Speedflow already exists in #{@project_path}")
        end
      end
    end
  end
end
