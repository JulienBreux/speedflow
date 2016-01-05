module Speedflow
  module Adapters
    module PM
      class Jira < Speedflow::Configurable
        # Configure adapter
        def configure!
          @settings[:host] = @command.ask("Host?".colorize(:light_blue), String)
          @settings[:port] = @command.ask("Port?".colorize(:light_blue), Integer).to_i
          @settings[:project] = @command.ask("Project ID?".colorize(:light_blue), String)

          @command.say("Think to add this following lines to your ~/.Xrc file:".colorize(:light_blue))
          @command.say("export JIRA_USER=username".colorize(:grey))
          @command.say("export JIRA_PASSWORD=password".colorize(:grey))
        end
      end
    end
  end
end
