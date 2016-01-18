module Speedflow
  module Commands
    class Review < Speedflow::Commands::Abstract
      def call(args, options)
        settings = @configuration.settings

        pm_adapter = Speedflow::Mod.instance(:PM, settings, @project_path, true) if settings[:PM]
        vcs_adapter = Speedflow::Mod.instance(:VCS, settings, @project_path, true) if settings[:VCS]
        scm_adapter = Speedflow::Mod.instance(:SCM, settings, @project_path, true) if settings[:SCM]

        vcs_adapter.create_pull_request(scm_adapter, pm_adapter) if settings[:VCS][:create_pull_request]
      end
    end
  end
end
