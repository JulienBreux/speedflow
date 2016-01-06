module Speedflow
  module Adapters
    module VCS
      require "git"

      class Github < Speedflow::Configurable
        # Configure adapter
        def configure!
          @command.choose do |menu|
            git = Git.open(@project_path)

            menu.header = "Remote?".colorize(:light_blue)
            menu.choices(*git.remotes) do |remote|
              @settings[:remote] = remote.to_s
            end
            menu.default = git.remotes.first.name
          end

          issue_create = @command.agree("Create issue in GitHub? (y/n)".colorize(:light_blue))
          @settings[:create_issue] = issue_create

          pr_create = @command.agree("Create pull-request in GitHub? (y/n)".colorize(:light_blue))
          @settings[:pr_create] = pr_create
        end
      end
    end
  end
end
