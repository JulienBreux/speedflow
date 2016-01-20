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
        if !@config.exists? || options.force
          Speedflow::Mod.mods(@config) do |mod|
            if agree(("Do you want to use a #{mod.name}? (y/n)").colorize(:light_blue))
              mod.ask_config!
            else
              @config.remove_key!(mod.id)
            end
          end

          unless @config.empty?
            @config.save

            say("Initialized speedflow in #{@config.path}".colorize(:light_green))
          else
            say('Initialized speedflow canceled'.colorize(:light_red))
          end
        else
          say("Speedflow already exists in #{@config.path}".colorize(:light_red))
        end
      end
    end
  end
end
