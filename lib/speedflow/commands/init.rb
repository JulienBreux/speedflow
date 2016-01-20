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
          Speedflow::Mod.mods(@config) do |mod|
            notice = "Do you want to use a #{mod.name}? (y/n)"
            if agree(notice.colorize(:light_blue))
              mod.ask_config!
            else
              @config.remove_key!(mod.id)
            end
          end

          unless @config.empty?
            @config.save

            notice = "Initialized speedflow in #{@config.path}"
            say(notice.colorize(:light_green))
          else
            say('Initialized speedflow canceled'.colorize(:light_red))
          end
        else
          notice = "Speedflow already exists in #{@config.path}"
          say(notice.colorize(:light_red))
        end
      end
    end
  end
end
