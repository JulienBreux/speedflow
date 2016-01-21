module Speedflow
  module Commands
    # Init command
    class Init < Speedflow::Commands::Abstract
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
        if !@config.exists? || options.force
          command
        else
          say("Speedflow already exists in #{@config.path}".colorize(:light_red))
        end
      end

      # Public: Command
      #
      # Examples
      #
      #    command
      #    # => nil
      #
      # Returns nothing.
      def command
        Speedflow::Mod.mods(@config) do |mod|
          if agree("Do you want to use a #{mod.name}? (y/n)".colorize(:light_blue))
            mod.ask_config!
          else
            @config.remove_key!(mod.id)
          end
        end

        if !@config.empty?
          say('Initialized speedflow canceled'.colorize(:light_red))
        else
          @config.save

          say("Initialized speedflow in #{@config.path}".colorize(:light_green))
        end
      end
    end
  end
end
