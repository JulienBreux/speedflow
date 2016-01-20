module Speedflow
  module Mods
    module VCS
      module Adapters
        # GitHub VCS adapter
        class Github < Speedflow::Adapter
          PR_PREFIX = '[WIP] '.freeze
          PR_DESC_SUFFIX = 'Powered by Speedflow'.freeze

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
            # TODO: Check settings
            subject = pm_adapter.read_issue(
              scm_adapter.key_from_current_branch
            )

            _inputs = {
              title: PR_PREFIX + subject,
              body: PR_DESC_SUFFIX,
              head: scm_adapter.current_branch.name,
              base: scm_adapter.base,
              state: 'open'
            }

            # pull_request =
            # #::Github::Client::PullRequests.new(
            # oauth_token: ENV["GITHUB_TOKEN"])
            # pull_request.create(scm_adapter.user,
            # scm_adapter.repository, inputs)
          end

          # Public: Request configuration from user CLI interaction
          #
          # Examples
          #
          #    ask_configuration
          #    # => nil
          #
          # Returns nothing.
          def ask_config!
            question = 'Create issue in GitHub? (y/n)'
            create_issue = agree(question.colorize(:light_blue))
            set(:create_issue, create_issue)

            question = 'Create pull-request in GitHub? (y/n)'
            create_pr = agree(question.colorize(:light_blue))
            set(:create_pull_request, create_pr)

            notice = 'Think to add this following lines to your ~/.Xrc file:'
            say(notice.colorize(color: :black, background: :light_blue))
            notice = 'export GITHUB_TOKEN=token'
            say(notice.colorize(:grey))
          end
        end
      end
    end
  end
end
