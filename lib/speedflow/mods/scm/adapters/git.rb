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

            workflow = @settings[:workflow] || "none"
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
