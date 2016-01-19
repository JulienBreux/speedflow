module Speedflow
  module Mods
    module VCS
      module Adapters
        # GitHub VCS adapter
        class Github
          # @return [Hash] Hash of settings
          attr_accessor :settings

          PR_PREFIX = "[WIP] "
          PR_DESC_SUFFIX = "Powered by Speedflow"

          # Public: Create an instance of
          # Speedflow::Mods::VCS::Adapters::Github
          #
          # project_path - Project path.
          # settings     - Hash of mod or adapter settings.
          #
          # Examples
          #
          #    Speedflow::Mods::VCS::Adapters::Git.new('.', {})
          #
          # Returns nothing.
          def initialize(project_path, settings = {})
            @project_path = project_path
            @settings = settings || {}
          end

          # Public: Create pull request
          #
          # scm_adapter - Speedflow::Mods::SCM::Adapters::<adapter>.new
          # pm_adapter  - Speedflow::Mods::PM::Adapters::<adapter>.new
          #
          # Examples
          #
          #    create_pull_request(
          #         Speedflow::Mods::SCM::Adapters::<adapter>.new,
          #         Speedflow::Mods::PM::Adapters::<adapter>.new
          #    )
          #
          # Returns nothing.
          def create_pull_request(scm_adapter, pm_adapter)
            # TODO Check settings
            subject = pm_adapter.read_issue(
              scm_adapter.key_from_current_branch
            )

            inputs = {
              title: PR_PREFIX+subject,
              body: PR_DESC_SUFFIX,
              head: scm_adapter.current_branch.name,
              base: scm_adapter.base,
              state: "open",
            }

            p inputs
            p scm_adapter.user
            p scm_adapter.repository
=begin
            pull_request = ::Github::Client::PullRequests.new(oauth_token: ENV["GITHUB_TOKEN"])
            pull_request.create(scm_adapter.user, scm_adapter.repository, inputs)
=end
          end

          # Public: Request configuration from user CLI interaction
          #
          # Examples
          #
          #    ask_configuration
          #    # => nil
          #
          # Returns nothing.
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
