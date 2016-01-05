module Speedflow
  module Adapters
    module SCM
      class Git < Speedflow::Configurable
        WORKFLOWS = [:none, :gitflow]
        DEFAULT_WORKFLOW = :none

        # Configure adapter
        def configure!
          @command.choose do |menu|
            menu.prompt = "Workflow?".colorize(:light_blue)
            menu.choices(*WORKFLOWS) do |workflow|
              @settings[:workflow] = workflow.to_s
            end
            menu.default = DEFAULT_WORKFLOW
          end
        end
      end
    end
  end
end
