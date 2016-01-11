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
          say("Project manager ".colorize(:light_blue))

          #adapter = Speedflow::Adapter.instance(:pm, settings[:pm])
          #issue_id = adapter.create(subject: options.subject)
        end

        # Service control manager part
        if @configuration.settings[:SCM]
          say("Service control manager".colorize(:light_blue))
        end

        # Version control system part
        if @configuration.settings[:VCS]
          say("Version control system ".colorize(:light_blue))
        end
=begin
Check if PM is used
  Load adapter
    Create issue
      Keep ID
      Keep URL

Check if SCM is used
  Load adapter
    Stash if is necessary
    Create branch with good format/workflow
      Format (none): ${issue.id}-${subject.slug}
      Format (gitflow): features/${issue.id}-${subject.slug}

Check if VCS is used
  Load adapter
    Create pr to remote if enabled
      Link issue to PM if enabled
        Add VSC link to PM description
        Add PM link to VCS description
    Create issue if enabled
      Add PM link to VCS description
      Add VSC link to PM description
=end
      end
    end
  end
end
