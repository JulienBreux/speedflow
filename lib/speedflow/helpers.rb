module Speedflow
  # Speedflow helpers
  module Helpers
    # Public: Notice
    #
    # Examples
    #
    #    notice 'Hello'
    #    # => nil
    #
    # Returns nothing.
    def notice(message)
      say(message.colorize(:light_blue))
    end

    # Public: Success
    #
    # Examples
    #
    #    success 'Ok'
    #    # => nil
    #
    # Returns nothing.
    def success(message)
      say(message.colorize(:light_green))
    end

    # Public: Error
    #
    # Examples
    #
    #    error 'Error'
    #    # => nil
    #
    # Returns nothing.
    def error(message)
      say(message.colorize(:light_red))
    end
  end
end
