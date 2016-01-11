module Speedflow
  module Commands
    class Abstract
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
