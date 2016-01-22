require 'test_helper'
require 'stringio'

class TestSpeedflowMod < Minitest::Test
  MODS = {
    PM: {a: ['jira']},
    SCM: {a: ['git']},
    VCS: {a: ['github']}
  }

  def setup
    @path = File.expand_path('../fixtures/', __FILE__)
    @config = Speedflow::Config.new(@path, {TEST: {foo: :bar}})
  end

  def test_mods
    Speedflow::Mod.mods(@config) do |mod|
      # Mod instance test
      mod_class = Object.const_get("Speedflow::Mods::#{mod.id}::Mod")
      assert_instance_of(mod_class, mod)

      # Mod ask test
      #mod.ask_config!

      # Adapters list test
      mod.adapters.each do |adapter_name|
        assert_includes(MODS[mod.id][:a], adapter_name)

        # Adapter test
        adapter_class = Object.const_get("Speedflow::Mods::#{mod.id}::Adapters::#{adapter_name.capitalize}")
        adapter = mod.adapter(adapter_name)
        assert_instance_of(adapter_class, adapter)
      end
    end
  end
end