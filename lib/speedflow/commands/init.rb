module Speedflow
  module Commands
    class Init < Speedflow::Commands::Abstract
      def call(args, options)
        if !@configuration.exists? || options.force
          # TODO Convert to block
          Speedflow::Mod.mods.each do |ref|
            mod = Speedflow::Mod.instance(ref.first, @configuration.settings[ref.first] || {}, @project_path)
            if agree(("Do you want to use a "+mod.name+"? (y/n)").colorize(:light_blue))
              mod.ask_configuration
              @configuration.settings[ref.first] = mod.settings
            end
          end

          unless @configuration.settings.empty?
            @configuration.save

            say("Initialized speedflow in #{@project_path}".colorize(:light_green))
          else
            say("Initialized speedflow canceled".colorize(:light_red))
          end
        else
          say("Speedflow already exists in #{@project_path}".colorize(:light_red))
        end

      end
    end
  end
end
