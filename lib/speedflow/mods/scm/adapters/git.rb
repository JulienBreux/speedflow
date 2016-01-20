module Speedflow
  module Mods
    module SCM
      module Adapters
        # Git SCM adapter
        class Git < Speedflow::Adapter
          DEFAULT_PORT = 443
          WORKFLOWS = [:none, :gitflow]
          DEFAULT_WORKFLOW = :none

          # Public: Create branch
          # TODO Move
          #
          # Examples
          #
          #    create_branch("hello world", "SF-01")
          #    # => {name: "SF-01-hello-world"}
          #
          # Returns hash of branch.
          def create_branch(subject, issue_key)
            # TODO Check settings
            subject = ActiveSupport::Inflector.parameterize(subject)

            if workflow == "none"
              branch_name = issue_key+"-"+subject

              git = ::Git.open(@project_path)
              git.branch(branch_name).checkout
              git.push(@settings[:remote], branch_name)
            elsif workflow == "gitflow"

            end

            {name: branch_name}
          end

          # Public: Get current branch
          # TODO Move to abstract SCM adapter
          #
          # Examples
          #
          #    current_branch
          #    # => Git::Branch
          #
          # Returns string of key.
          def current_branch
            git = ::Git.open(@project_path)
            git.branches.local.find(&:current)
          end

          # Public: Get issue key from current branch
          # TODO Move to abstract SCM adapter
          #
          # Examples
          #
          #    key_from_current_branch
          #    # =>
          #
          # Returns string of key.
          def key_from_current_branch
            # TODO Test format
            current_branch.name.split('-')[0..1].join('-')
          end

          # Public: Get workflow
          # TODO Move to abstract SCM adapter
          #
          # Examples
          #
          #    workflow
          #    # => "none"
          #
          # Returns string of key.
          def workflow
            @settings[:workflow] || "none"
          end

          # Public: Get base
          # TODO Move to abstract SCM adapter
          #
          # Examples
          #
          #    base
          #    # => "master"
          #
          # Returns String of base branch.
          def base
            case workflow
            when "gitflow"
              "develop"
            else
              "master"
            end
          end

          # Public: Get user of remote repository
          # TODO Move to abstract SCM adapter
          #
          # Examples
          #
          #    user
          #    # => "JulienBreux"
          #
          # Returns string of user.
          def user
            # TODO Check settings
            remote = git.remotes(@settings[:remote])
            p remote
          end

          # Public: Get repository
          # TODO Move to abstract SCM adapter
          #
          # Examples
          #
          #    user
          #    # => "speedflow"
          #
          # Returns string repository.
          def repository

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
            choose do |menu|
              git = ::Git.open(@config.path)

              menu.header = 'Remote?'.colorize(:light_blue)
              menu.choices(*git.remotes) do |remote|
                set(:remote, remote.to_s)
              end
              menu.default = git.remotes.first.name
            end

            choose do |menu|
              menu.header = 'Workflow?'.colorize(:light_blue)
              menu.choices(*WORKFLOWS) do |workflow|
                unless DEFAULT_WORKFLOW == workflow
                  set(:workflow, workflow.to_s)
                end
              end
              menu.default = DEFAULT_WORKFLOW
            end
          end
        end
      end
    end
  end
end
