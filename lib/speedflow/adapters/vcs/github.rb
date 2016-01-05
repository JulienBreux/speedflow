module Speedflow
  module Adapters
    module VCS
      require "git"

      class Github < Speedflow::Configurable
        # Configure adapter
        def configure!
          repository = @command.ask("Repository?".colorize(:light_blue), String) do |q|
            # TODO Check GIT repo!
            git = Git.open(@project_path)
            q.default = git.remote(:origin).url
          end
          @settings[:repository] = repository.to_s
        end
      end
    end
  end
end
