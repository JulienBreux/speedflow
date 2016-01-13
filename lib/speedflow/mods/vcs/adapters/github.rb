module Speedflow
  module Mods
    module VCS
      module Adapters
        class Github
          attr_accessor :settings

          PR_PREFIX = "[WIP] "

          def initialize(project_path, settings = {})
            @project_path = project_path
            @settings = settings || {}
          end

          def create_pull_request(subject, issue_key, branch, prefix=PR_PREFIX)
            # TODO Check settings

            inputs = {
              title: PR_PREFIX+subject,
              body: "Powered by Speedflow",
              head: branch,
              base: "master",
              state: "open",
            }
            pull_request = ::Github::Client::PullRequests.new(oauth_token: ENV["GITHUB_TOKEN"])
            pull_request.create("JulienBreux", "speedflow-sandbox", inputs)
          end

          def ask_configuration
            create_issue = agree("Create issue in GitHub? (y/n)".colorize(:light_blue))
            @settings[:create_issue] = create_issue

            create_pr = agree("Create pull-request in GitHub? (y/n)".colorize(:light_blue))
            @settings[:create_pull_request] = create_pr

            say("Think to add this following lines to your ~/.Xrc file:".colorize(color: :black, background: :light_blue))
            say("export GITHUB_TOKEN=token".colorize(:grey))
          end
        end
      end
    end
  end
end
