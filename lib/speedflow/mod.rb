module Speedflow
  # Manage mod
  class Mod
    # Public: Gets/Sets the Symbol of module reference,
    # the String name of the mod, the Hash of settings.
    attr_accessor :ref, :name, :settings

    # rubocop:disable MutableConstant
    MODS = {}
    # rubocop:enable MutableConstant

    # Public: Create an instance of Speedflow::Mod
    #
    # ref          - Reference of mod.
    # project_path - Project path.
    # name         - Mod name.
    # settings     - Hash of mod or adapter settings.
    #
    # Examples
    #
    #    Speedflow::Mod.new(:MOD, '.', 'Test', {foo: :bar})
    #
    # Returns nothing.
    def initialize(ref, project_path, name = 'unknown mod', settings = {})
      @ref = ref
      @name = name
      @settings = settings
      @project_path = project_path
    end

    # Public: Request configuration from user CLI interaction
    #
    # Examples
    #
    #    ask_configuration
    #    # => nil
    #
    # Returns nothing.
    def ask_configuration
      Kernel.choose do |menu|
        menu.header = 'Please choose your an adapter?'.colorize(:light_blue)
        menu.choices(*adapters) do |adapter_name|
          adapter(adapter_name).ask_configuration

          @settings[:adapter] = adapter_name
          @settings.merge(adapter(adapter_name).settings)
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
      path = [File.dirname(__FILE__), 'mods', @ref, 'adapters', '[!adapter]*']
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
        'Speedflow', 'Mods', @ref, 'Adapters', adapter.capitalize
      ].join('::')
      Object.const_get(adapter_class).new(@project_path, @settings)
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
    def self.mods
      MODS
    end

    # Public: Register mod
    #
    # ref  - Reference of mod.
    # name - Mod name.
    #
    # Examples
    #
    #    register(:MOD, "My mod")
    #    # => nil
    #
    # Returns nothing.
    def self.register(ref, name)
      MODS[ref] = { instance: self, ref: ref, name: name }
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
