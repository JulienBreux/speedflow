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

          def ask_configuration
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
