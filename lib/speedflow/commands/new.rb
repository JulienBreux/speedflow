module Speedflow
  module Commands
    class New < Speedflow::Commands::Abstract
      def call(args, options)
        # TODO BEGIN - Move to an option helper
        unless options.subject
          say("Missing options: subject".colorize(:light_red))
          exit
        end
        # TODO END - Move to an option helper

        success = true

        # Project Manager part
        if @configuration.settings[:PM]
          say("Project manager".colorize(:light_blue))

          mod = Speedflow::Mod.instance(:PM, @configuration.settings[:PM], @project_path)
          adapter = mod.adapter(@configuration.settings[:PM][:adapter])

          issue = adapter.create_issue(options.subject)
          if issue
            say("Issue created: #{issue["key"]}".colorize(:light_green))
          end
        end

        # Service control manager part
        if @configuration.settings[:SCM]
          say("Service control manager".colorize(:light_blue))

          mod = Speedflow::Mod.instance(:SCM, @configuration.settings[:SCM], @project_path)
          adapter = mod.adapter(@configuration.settings[:SCM][:adapter])

          branch = adapter.create_branch(options.subject, issue["key"] || nil)
          if branch
            say("Local branch created: #{branch[:name]}".colorize(:light_green))
          end
        end
      end
    end
  end
end
