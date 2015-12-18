module Speedflow
  class CommandLine
    attr_accessor :configuration, :global_options, :command_options, :parameters

    def initialize(command, command_options, global_options, parameters, project_path)
      self.command_options = command_options
      self.parameters = parameters
      self.project_path = project_path
      success = self.send(command)
      exit 1 if !success
    end

    def init
      puts "# Initializing project flow"

      # TODO
    end

    def start
      puts "# Start project flow item"

      # TODO
    end
  end
end
