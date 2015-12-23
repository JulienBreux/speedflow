module Speedflow
  class CommandLine
    attr_accessor :configuration, :global_options, :command_options, :parameters, :project_path

    def initialize(command, command_options, global_options, parameters, project_path)
      self.command_options = command_options
      self.parameters = parameters
      self.project_path = project_path
      success = self.send(command)
      exit 1 if !success
    end

    def init
      puts "# Initializing project flow"
=begin
      flow = Flow.new(@project_path)

      vsc = VSC.new
      vsc.adapter = :git
      flow.vsc = vsc

      scm = SCM.new
      scm.adapter = :github
      flow.scm = scm

      pm = PM.new
      pm.adapter = :jira
      flow.pm = pm

      flow.serialize
      # TODO
      return nil
=end
    end

    def start
      puts "# Start project flow item"

      # TODO
    end
  end
end
