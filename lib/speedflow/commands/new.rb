module Speedflow
  module Commands
    # New command
    class New < Speedflow::Commands::Abstract
      # Public: Call command
      #
      # args    - Arguments.
      # options - Options.
      #
      # Examples
      #
      #    call({}, {subject: "test"})
      #    # => nil
      #
      # Returns nothing.
      def call(args, options)
        # TODO BEGIN - Move to an option helper
        unless options.subject
          say("Missing options: subject".colorize(:light_red))
          exit
        end
        # TODO END - Move to an option helper

        settings = @configuration.settings

        # Project Manager part
        if settings[:PM]
          say("Project manager".colorize(:light_blue))

          adapter = Speedflow::Mod.instance(:PM, settings, @project_path, true)

          issue = adapter.create_issue(options.subject)
          if issue
            say("Issue created: #{issue["key"]}".colorize(:light_green))
          end
        end

        # Service control manager part
        if settings[:SCM]
          say("Service control manager".colorize(:light_blue))

          adapter = Speedflow::Mod.instance(:SCM, settings, @project_path, true)

          branch = adapter.create_branch(options.subject, issue["key"] || nil)
          if branch
            say("Local branch created: #{branch[:name]}".colorize(:light_green))
          end
        end
      end
    end
  end
end
