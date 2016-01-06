module Speedflow
  module Adapters
    module PM
      class Jira < Speedflow::Configurable
        DEFAULT_PORT = 443

        # Configure adapter
        def configure!
          host = @command.ask("Host?".colorize(:light_blue), String)
          @settings[:host] = host.to_s

          port = @command.ask("Port?".colorize(:light_blue), Integer) do |q|
            q.default = DEFAULT_PORT
          end
          unless DEFAULT_PORT == port.to_i
            @settings[:port] = port.to_i
          end

          project = @command.ask("Project ID?".colorize(:light_blue), String)
          @settings[:project] = project.to_s

          # TODO Fix response
          # TODO Add abstract
          issue_create = @command.agree("Create issue in Jira? (y/n)".colorize(:light_blue))
          @settings[:create_issue] = issue_create

          # TODO Add notice method
          @command.say("Think to add this following lines to your ~/.Xrc file:".colorize(:light_blue))
          @command.say("export JIRA_USER=username".colorize(:grey))
          @command.say("export JIRA_PASSWORD=password".colorize(:grey))
        end
      end
    end
  end
end
