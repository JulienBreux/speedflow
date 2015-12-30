module Speedflow
  module Adapters
    module SCM
      class Git < Speedflow::Configurable
        # Configure adapter
        def configure!
          @settings[:workflow] = @command.ask("Workflow?".colorize(:light_blue))
        end
      end
    end
  end
end
