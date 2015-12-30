module Speedflow
  module Adapters
    module VCS
      class Github < Speedflow::Configurable
        # Configure adapter
        def configure!
          @settings[:repository] = @command.ask("Repository?".colorize(:light_blue), String)
          @settings[:workflow] = @command.ask("Workflow?".colorize(:light_blue))
        end
      end
    end
  end
end
