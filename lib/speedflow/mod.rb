module Speedflow
  # Manage mod
  class Mod
    # Public: Gets/Sets the Symbol of mod id
    attr_accessor :id

    # Public: Gets/Sets the String name of the mod
    attr_accessor :name

    # Public: Gets/Sets the config object
    attr_accessor :config

    # rubocop:disable MutableConstant
    MODS = {}
    # rubocop:enable MutableConstant

    # Public: Create an instance of Speedflow::Mod
    #
    # id     - Mod ID.
    # config - Config.
    # name   - Mod name.
    #
    # Examples
    #
    #    Speedflow::Mod.new(:MOD, <Speedflow::Config>, 'Test')
    #
    # Returns nothing.
    def initialize(id, config, name = 'unknown mod')
      @id = id
      @name = name
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
      Kernel.choose do |menu|
        menu.header = 'Please choose your an adapter?'.colorize(:light_blue)
        menu.choices(*adapters) do |adapter_name|
          adapter(adapter_name).ask_config!
        end
      end
    end

    # Public: List all adapters of module
    #
    # Examples
    #
    #    adapters
    #    # => ["foo", "bar", "baz"]
    #
    # Returns array of adapters string.
    def adapters
      path = [File.dirname(__FILE__), 'mods', @id, 'adapters', '[!adapter]*']
      Dir[path.join('/')].map { |f| File.basename(f).split('.').first }
    end

    # Public: Get an adapter of mod
    #
    # adapter - Adapter name
    #
    # Examples
    #
    #    adapter(:adapter_name)
    #    # => Speedflow::Mods::<mod>::Adapters::<adapter>
    #
    # Returns adapter object.
    def adapter(adapter)
      adapter_class = [
        'Speedflow', 'Mods', @id, 'Adapters', adapter.capitalize
      ].join('::')
      Object.const_get(adapter_class).new(@id, @config)
    end

    # Public: Register mod
    #
    # ref  - Reference of mod.
    # name - Mod name.
    #
    # Examples
    #
    #    mods
    #    # => {}
    #
    # Returns hash of mods.
    def self.mods(config)
      MODS.each do |id, meta|
        yield(
          meta[:instance].new(meta[:id], config, meta[:name])
        )
      end
    end

    # Public: Register mod
    #
    # id   - Mod ID.
    # name - Mod name.
    #
    # Examples
    #
    #    register(:MOD, "My mod")
    #    # => nil
    #
    # Returns nothing.
    def self.register(id, name)
      MODS[id] = { instance: self, id: id, name: name }
    end

    # Public: Get mod or mod adapter instance
    #
    # ref              - Reference of mod.
    # project_path     - Project path.
    # adapter_instance - Use to get adapter instance.
    # settings         - Hash of mod or adapter settings.
    #
    # Examples
    #
    #    instance(:MOD, "./", {foo: "", bar: "", baz: ""})
    #    # => Speedflow::Mods::<MOD>::Mod
    #
    #    instance(:MOD, "./", true, {foo: "", bar: "", baz: ""})
    #    # => Speedflow::Mods::<MOD>::Adapters::<adapter>
    #
    # Returns mod or mod adapter.
    def self.instance(ref, project_path, adapter_instance, settings = {})
      mod = MODS[ref][:instance].new(
        ref, project_path, MODS[ref][:name], settings[ref]
      )
      adapter_instance ? mod.adapter(settings[ref][:adapter]) : mod
    end
  end
end
