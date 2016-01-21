require 'test_helper'

require 'speedflow/config'

class TestSpeedflowConfig < Minitest::Test
  def setup
    @path = File.expand_path('../fixtures/', __FILE__)
    @config = Speedflow::Config.new(@path, {foo: :bar, qux: :quux})
  end

  def test_hash_with_default_value
    assert_equal(@config.to_h, {foo: :bar, qux: :quux})
  end

  def test_empty
    assert !@config.empty?
  end

  def test_merge
    @config.merge!({foo: :baz})
    assert_equal(@config.to_h, {foo: :baz, qux: :quux})
  end

  def test_remove_key
    @config.remove_key!(:qux)
    assert_equal(@config.to_h, {foo: :bar})
  end

  def test_load
    @config.load!
    hash = {:first=>{:sub_first=>1}, :second=>{:sub_second=>2}, :third=>{:sub_third=>3}}
    assert_equal(@config.to_h, hash)
  end

  def test_not_load
    path = File.expand_path('../breux/', __FILE__)
    config = Speedflow::Config.new(path)
    config.load!
    assert_equal(config.to_h, {})
  end

  def test_exists
    assert(@config.exists?)
  end

  def test_save
    file = MiniTest::Mock.new
    file.expect :write, nil, ["---\nfoo: :bar\nqux: :quux\n"]

    File.stub :open, file do
      @config.save
    end
  end
end
