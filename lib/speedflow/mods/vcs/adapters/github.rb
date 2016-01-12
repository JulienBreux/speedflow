module Speedflow
  module Mods
    module VCS
      module Adapters
        class Github
          attr_accessor :settings

          def initialize(project_path, settings = {})
            @project_path = project_path
            @settings = settings || {}
          end

          def ask_configuration
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
