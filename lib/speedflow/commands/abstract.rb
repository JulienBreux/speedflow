module Speedflow
  module Commands
    # Abstract command class
    class Abstract
      # Public: Create an instance of Speedflow::App
      #
      # specs        - Gem.loaded_specs.
      # config       - Speedflow::Configuration
      # command      - Command.
      #
      # Examples
      #
      #    Speedflow::Commands::<Command>.new(
      #        Gem.loaded_specs,
      #        Speedflow::Config.load(PROJECT_PATH)
      #        command,
      #    )
      #
      # Returns nothing.
      def initialize(specs, config, command)
        @specs = specs
        @config = config
        @command = command
      end
    end
  end
end
