module Speedflow
  class Configurable
    def initialize(command, project_path)
      @command = command
      @project_path = project_path
      @settings = {}
      @klass = self.class.name.demodulize
    end

    # Configure object
    def configure!
      @command.choose do |menu|
        menu.prompt = "Please choose your an adapter?".colorize(:light_blue)
        menu.choices(*adapters) do |adapter|
          adapterClass = ["Speedflow","Adapters", @klass, adapter.capitalize].join("::")
          adapterObject = Object.const_get(adapterClass).new(@command, @project_path)
          adapterObject.configure!

          @settings[:adapter] = adapter.to_s
          @settings = @settings.merge(adapterObject.to_configuration)
        end
      end
    end

    # Export to configuration
    def to_configuration
      @settings
    end

    private

    # List adapters
    def adapters
      adpts = []
      Dir[File.dirname(__FILE__)+"/adapters/#{@klass.downcase}/[!adapter]*"].each do |file|
        adpts << File.basename(file).split(".").first
      end
      adpts
    end
  end
end
