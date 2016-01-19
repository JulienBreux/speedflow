module Speedflow
  module Commands
    # Init command
    class Init < Speedflow::Commands::Abstract
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
        if !@configuration.exists? || options.force
          # TODO Convert to block
          Speedflow::Mod.mods.each do |ref|
            mod = Speedflow::Mod.instance(
              ref.first,  @project_path, false, @configuration.settings || {}
            )
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
