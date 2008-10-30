require File.join(File.dirname(__FILE__), 'test_helper')

class ValueTest < Test::Unit::TestCase
  def setup
    @string = "value1"
  end

  def test_initialize
    css = Value.new("value1")
    assert_equal @string, css.to_s
  end
end
