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
          error 'Missing options: subject'
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
        issue = nil

        # Project Manager part
        if @config.settings[:PM]
          adapter = Speedflow::Mod.instance(:PM, @config.settings, @config.path, true)
          issue = adapter.create_issue(subject)

          notice 'Project manager'
          success "Issue created: #{issue['key']}" if issue
        end

        # Service control manager part
        if @config.settings[:SCM]
          adapter = Speedflow::Mod.instance(:SCM, @config.settings, @config.path, true)

          notice 'Service control manager'
          unless issue.nil?
            branch = adapter.create_branch(subject, issue['key'] || nil)
            if branch
              success "Local branch created: #{branch[:name]}"
            end
          end
        end

      end
    end
  end
end
