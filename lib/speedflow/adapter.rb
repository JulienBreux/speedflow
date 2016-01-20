module Speedflow
  # Speedflow configuration
  class Adapter
    # @return [<Speedflow::Config>] Config
    attr_accessor :config

    # Public: Create an instance of
    # Speedflow::Mods::PM::Adapters::Jira
    #
    # config - Configuration.
    #
    # Examples
    #
    #    Speedflow::Mods::VCS::Adapters::Git.new(
    #       <Speedflow::Config.load>
    #    )
    #
    # Returns nothing.
    def initialize(mod_id, config)
      @mod_id = mod_id
      @config = config
    end

    # Public: Request configuration from user CLI interaction
    #
    # Examples
    #
    #    ask_configuration
    #    # => nil
    #
    # Returns nothing.
    def ask_config!
      say('No configuration for this adapter.'.colorize(:grey))
    end

    # Public: Set configuration
    #
    # Examples
    #
    #    set(:key, "value")
    #    # => nil
    #
    # Returns nothings.
    def set(key, value)
      @config.merge!(Hash[@mod_id, Hash[key, value]])
    end

    # Public: Get configuration
    #
    # Examples
    #
    #    get(:key)
    #    # => "baz"
    #
    # Returns value.
    def get(key)
      @config.to_h[@mod_id][key] if @config.to_h[@mod_id] && @config.to_h[@mod_id][key]
    end
  end
end
