require 'test_helper'

class TestSpeedflowHelpers < Minitest::Test
  include Speedflow::Helpers

  def setup
    $terminal = HighLine.new(nil, (@output = StringIO.new))
  end

  def test_info
    assert_equal(info('test'), nil)
    assert_equal(@output.string, "\e[0;39;49mtest\e[0m\n")
  end

  def test_notice
    assert_equal(notice('test'), nil)
    assert_equal(@output.string, "\e[0;94;49mtest\e[0m\n")
  end

  def test_success
    assert_equal(success('test'), nil)
    assert_equal(@output.string, "\e[0;92;49mtest\e[0m\n")
  end

  def test_error
    assert_equal(error('test'), nil)
    assert_equal(@output.string, "\e[0;91;49mtest\e[0m\n")
  end
end
