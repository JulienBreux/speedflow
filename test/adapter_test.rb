require 'test_helper'

class TestSpeedflowAdapter < Minitest::Test
  def setup
    $terminal = HighLine.new(nil, (@output = StringIO.new))

    @path = File.expand_path('../fixtures/', __FILE__)
    @config = Speedflow::Config.new(@path, {TEST: {foo: :bar}})

    @adapter = Speedflow::Adapter.new(:TEST, @config)
  end

  def test_ask
    assert_equal(@adapter.ask_config!, nil)
    assert_equal(@output.string, "\e[0;39;49mNo configuration for this adapter.\e[0m\n")
  end

  def test_set
    assert_equal(@adapter.set(:foo, 'bar'), {TEST: {foo: 'bar'}})
  end

  def test_get
    assert_equal(@adapter.get(:foo), :bar)
  end
end
