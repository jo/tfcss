require File.join(File.dirname(__FILE__), 'test_helper')

class ElementTest < Test::Unit::TestCase
  def setup
    @stylesheet = Stylesheet.new("test", "")
    @string =<<STR
  property1: value1;
  property2: value2;
STR
    @hash = {
      "property1" => "value1",
      "property2" => "value2"
    }
    @complete_string =<<STR
element1 {
  property1: value1;
  property2: value2;
}
STR
  end

  def test_initialize_with_string
    css = Element.new("element1", @string, @stylesheet)
    assert_equal @complete_string.strip, css.to_s
  end

  def test_initialize_with_hash
    css = Element.new("element1", @hash, @stylesheet)
    assert_equal @complete_string.strip, css.to_s
  end
end
