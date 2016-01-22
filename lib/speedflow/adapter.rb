module Speedflow
  # Speedflow configuration
  class Adapter
    include Speedflow::Helpers

    # @return [<Speedflow::Config>] Config
    attr_accessor :config

    # Public: Create an instance of
    # Speedflow::Mods::PM::Adapters::Jira
    #
    # mod_id - Mod ID.
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
      info 'No configuration for this adapter.'
    end

    # Public: Set configuration
    #
    # key    - Key of configuration set
    # value  - Value of configuration set
    #
    # Examples
    #
    #    set(:key, 'value')
    #    # => {key: 'value'}
    #
    # Returns hash of configuration.
    def set(key, value)
      @config.merge!(Hash[@mod_id, Hash[key, value]])
    end

    # Public: Get configuration
    #
    # key    - Key of configuration set
    #
    # Examples
    #
    #    get(:key)
    #    # => "baz"
    #
    # Returns the key value.
    def get(key)
      @config.to_h[@mod_id][key] if @config.to_h[@mod_id] && @config.to_h[@mod_id][key]
    end
  end
end
