module Speedflow
  module Commands
    # New command
    class New < Speedflow::Commands::Abstract
      # Public: Call command
      #
      # _args   - Arguments.
      # options - Options.
      #
      # Examples
      #
      #    call({}, {subject: "test"})
      #    # => nil
      #
      # Returns nothing.
      def call(_args, options)
        # TODO: BEGIN - Move to an option helper
        unless options.subject
          say('Missing options: subject'.colorize(:light_red))
          exit
        end
        # TODO: END - Move to an option helper

        command(options.subject)
      end

      # Public: Command
      #
      # Examples
      #
      #    command
      #    # => nil
      #
      # Returns nothing.
      def command(subject)
        settings = @configuration.settings

        # Project Manager part
        if settings[:PM]
          say('Project manager'.colorize(:light_blue))

          adapter = Speedflow::Mod.instance(:PM, settings, @config.path, true)

          issue = adapter.create_issue(subject)
          say("Issue created: #{issue['key']}".colorize(:light_green)) if issue
        end

        # Service control manager part
        if settings[:SCM]
          say('Service control manager'.colorize(:light_blue))

          adapter = Speedflow::Mod.instance(:SCM, settings, @config.path, true)

          branch = adapter.create_branch(subject, issue['key'] || nil)
          if branch
            say("Local branch created: #{branch[:name]}".colorize(:light_green))
          end
        end
      end
    end
  end
end
