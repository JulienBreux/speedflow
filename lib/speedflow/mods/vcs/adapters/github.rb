module Speedflow
  module Mods
    module VCS
      module Adapters
        require "git"

        class Github
          attr_accessor :settings

          def initialize(project_path, settings = {})
            @project_path = project_path
            @settings = settings || {}
          end

          def ask_configuration
            choose do |menu|
              git = Git.open(@project_path)

              menu.header = "Remote?".colorize(:light_blue)
              menu.choices(*git.remotes) do |remote|
                @settings[:remote] = remote.to_s
              end
              menu.default = git.remotes.first.name
            end

            issue_create = agree("Create issue in GitHub? (y/n)".colorize(:light_blue))
            @settings[:create_issue] = issue_create

            pr_create = agree("Create pull-request in GitHub? (y/n)".colorize(:light_blue))
            @settings[:pr_create] = pr_create
          end
        end
      end
    end
  end
end
