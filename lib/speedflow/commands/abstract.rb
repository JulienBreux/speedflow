module Speedflow
  module Commands
    class Abstract
      def initialize(specs, project_path, command)
        @specs = specs
        @project_path = project_path
        @command = command
      end
    end
  end
end
