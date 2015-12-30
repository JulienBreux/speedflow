require 'test_helper'

class ConfigurableTest < MiniTest::Test
  def setup
    @configurable = Speedflow::Configurable.new(nil)
  end

  def test_default_configuration
    assert_instance_of Hash, @configurable.to_configuration
    assert_empty @configurable.to_configuration
  end
end
