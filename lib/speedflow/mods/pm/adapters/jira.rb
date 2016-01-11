module Speedflow
  module Mods
    module PM
      module Adapters
        class Jira
          attr_accessor :settings

          DEFAULT_PORT = 443

          def initialize(project_path, settings = {})
            @project_path = project_path
            @settings = settings || {}
          end

          def ask_configuration
            host = ask("Host?".colorize(:light_blue), String)
            @settings[:host] = host.to_s

            port = ask("Port?".colorize(:light_blue), Integer) do |q|
              q.default = DEFAULT_PORT
            end
            unless DEFAULT_PORT == port.to_i
              @settings[:port] = port.to_i
            end

            project = ask("Project ID?".colorize(:light_blue), String)
            @settings[:project] = project.to_s

            # TODO Fix response
            # TODO Add abstract
            issue_create = agree("Create issue in Jira? (y/n)".colorize(:light_blue))
            @settings[:create_issue] = issue_create

            # TODO Add notice method
            say("Think to add this following lines to your ~/.Xrc file:".colorize(color: :black, background: :light_blue))
            say("export JIRA_USER=username".colorize(:grey))
            say("export JIRA_PASSWORD=password".colorize(:grey))
          end
        end
      end
    end
  end
end
