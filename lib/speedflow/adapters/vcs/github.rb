module Speedflow
  module Adapters
    module VCS
      require "git"

      class Github < Speedflow::Configurable
        # Configure adapter
        def configure!
          @command.choose do |menu|
            git = Git.open(@project_path)

            menu.prompt = "Remote?".colorize(:light_blue)
            menu.choices(*git.remotes) do |remote|
              @settings[:remote] = remote.to_s
            end
            menu.default = git.remotes.first.name
          end
        end
      end
    end
  end
end
