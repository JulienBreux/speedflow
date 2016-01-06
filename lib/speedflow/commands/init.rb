module Speedflow
  module Commands
    class Init < Speedflow::Commands::Abstract
      def call(args, options)
        mods = {
          PM: "project manager",
          SCM: "service control manager",
          VCS: "version control system"
        }

        if !@configuration.exists? || options.force
          mods.each do |mod, name|
            if agree(("Do you want to use a "+name+"? (y/n)").colorize(:light_blue))
              modObject = Object.const_get("Speedflow::"+mod.to_s).new(@command, @project_path)
              modObject.configure!

              @configuration.settings[mod.downcase] = modObject.to_configuration
            end
          end

          unless @configuration.settings.empty?
            @configuration.save!

            @command.say("Initialized speedflow in #{@project_path}".colorize(:light_green))
          else
            @command.say("Initialized speedflow canceled".colorize(:light_red))
          end
        else
          @command.say("Speedflow already exists in #{@project_path}".colorize(:light_red))
        end
      end
    end
  end
end
