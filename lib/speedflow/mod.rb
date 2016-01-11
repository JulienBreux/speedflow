module Speedflow
  class Mod
    attr_accessor :ref, :name, :settings

    @@mods = {}

    def initialize(ref, name = "unknown mod", settings = {}, project_path)
      @ref = ref
      @name = name
      @settings = settings
      @project_path = project_path
    end

    def ask_configuration
      choose do |menu|
        menu.header = "Please choose your an adapter?".colorize(:light_blue)
        menu.choices(*adapters) do |adapter_name|
          adapter(adapter_name).ask_configuration

          @settings[:adapter] = adapter_name
          @settings.merge(adapter(adapter_name).settings)
        end
      end
    end

    # List adapters
    def adapters
      path = [File.dirname(__FILE__), "mods", @ref, "adapters", "[!adapter]*"]
      Dir[path.join("/")].map { |f| File.basename(f).split(".").first }
    end

    # Get adapter
    def adapter(adapter)
      adapterClass = ["Speedflow", "Mods", @ref, "Adapters", adapter.capitalize].join("::")
      Object.const_get(adapterClass).new(@project_path, @settings)
    end

    #########
    def self.mods
      @@mods
    end

    def self.register(ref, name)
      @@mods[ref] = {instance: self, ref: ref, name: name}
    end

    def self.instance(ref, settings = {}, project_path)
      @@mods[ref][:instance].new(ref, @@mods[ref][:name], settings, project_path)
    end
  end
end
