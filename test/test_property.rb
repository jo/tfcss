require File.join(File.dirname(__FILE__), 'test_helper')

class PropertyTest < Test::Unit::TestCase
  def setup
    @string = "value1 value2"
    @array = %w{value1 value2}
    @hash = {
      1 => "value1",
      2 => "value2",
    }
    @complete_string = "  property1: value1 value2;"
  end

  def test_initialize_with_string
    css = Property.new("property1", @string)
    assert_equal @complete_string, css.to_s
  end

  def test_initialize_with_array
    css = Property.new("property1", @array)
    assert_equal @complete_string, css.to_s
  end
end
