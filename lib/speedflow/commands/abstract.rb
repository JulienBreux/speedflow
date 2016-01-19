module Speedflow
  module Commands
    # Abstract command class
    class Abstract

      # Public: Create an instance of Speedflow::App
      #
      # specs         - Gem.loaded_specs.
      # project_path  - Project path.
      # command       - Command.
      # configuration - Speedflow::Configuration
      #
      # Examples
      #
      #    Speedflow::Commands::<Command>.new(
      #        Gem.loaded_specs,
      #        '.',
      #        command,
      #        Speedflow::Configuration
      #    )
      #
      # Returns nothing.
      def initialize(specs, project_path, command, configuration)
        @specs = specs
        @project_path = project_path
        @command = command
        @configuration = configuration
        @configuration.load
      end
    end
  end
end
