require File.join(File.dirname(__FILE__), 'test_helper')

class StylesheetTest < Test::Unit::TestCase
  def setup
    @string =<<STR
#element1 {
  property1: value1;
  property2: value2;
}
#element2 {
  property3: value3;
}
STR
  end

  def test_initialize_with_string
    css = Stylesheet.new(@string)
    assert_equal @string.strip, css.to_s
  end

  def test_initialize_with_hash
    hash = {
      "#element1" =>
      {
        "property1" => "value1",
        "property2" => "value2"
      },
      "#element2" =>
      {
        "property3" => "value3"
      }
    }
    css = Stylesheet.new(hash)
    assert_equal @string.strip, css.to_s
  end
end
