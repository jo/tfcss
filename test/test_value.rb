require File.join(File.dirname(__FILE__), 'test_helper')

class ValueTest < Test::Unit::TestCase
  def setup
    @stylesheet = Stylesheet.new("test", "")
    @element = Element.new("element1", "", @stylesheet)
    @property = Property.new("property1", "", @element)
  end

  def test_initialize
    css = Value.new("value1", @property)
    assert_equal "value1", css.to_s
  end
end
