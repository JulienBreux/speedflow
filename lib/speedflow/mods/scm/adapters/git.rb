module Speedflow
  module Mods
    module SCM
      module Adapters
        class Git
          attr_accessor :settings

          DEFAULT_PORT = 443
          WORKFLOWS = [:none, :gitflow]
          DEFAULT_WORKFLOW = :none

          def initialize(project_path, settings = {})
            @project_path = project_path
            @settings = settings || {}
          end

          # TODO Move
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

          def current_branch
            git = ::Git.open(@project_path)
            git.branches.local.find(&:current)
          end

          # TODO Move to abstract SCM adapter
          def key_from_current_branch
            # TODO Test format
            current_branch.name.split("-")[0..1].join("-")
          end

          # TODO Move to abstract SCM adapter
          def workflow
            @settings[:workflow] || "none"
          end

          # TODO Move to abstract SCM adapter
          def base
            case workflow
            when "gitflow"
              "develop"
            else
              "master"
            end
          end

          # TODO Move to abstract SCM adapter
          def user
            # TODO Check settings
            remote = git.remotes(@settings[:remote])
            p remote
          end

          def repository

          end

          def ask_configuration
            choose do |menu|
              git = ::Git.open(@project_path)

              menu.header = "Remote?".colorize(:light_blue)
              menu.choices(*git.remotes) do |remote|
                @settings[:remote] = remote.to_s
              end
              menu.default = git.remotes.first.name
            end

            choose do |menu|
              menu.header = "Workflow?".colorize(:light_blue)
              menu.choices(*WORKFLOWS) do |workflow|
                unless DEFAULT_WORKFLOW == workflow
                  @settings[:workflow] = workflow.to_s
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
