require 'test_helper'

require 'speedflow/config'

class TestSpeedflowAdapter < Minitest::Test
  def setup
    @config = Speedflow::Config.new(@path, {foo: :bar, qux: :quux})
  end
end
