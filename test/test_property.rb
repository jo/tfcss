require File.join(File.dirname(__FILE__), 'test_helper')

class PropertyTest < Test::Unit::TestCase
  def setup
    @result = "  property1: value1 value2;"
  end

  def test_to_s_with_unit
    string = "1px 1em 1% 1cm"
    css = Property.new("property1", string)
    assert_equal "  property1: 1px 1em 1% 1cm;", css.to_s
  end

  def test_initialize_with_string
    string = "value1 value2"
    css = Property.new("property1", string)
    assert_equal @result, css.to_s
  end

  def test_initialize_with_array
    array = %w{value1 value2}
    css = Property.new("property1", array)
    assert_equal @result, css.to_s
  end

  def test_initialize_with_hash_of_numbers
    hash = {
      2 => "value2",
      1 => "value1",
    }
    css = Property.new("property1", hash)
    assert_equal @result, css.to_s
  end

  def test_initialize_with_hash_of_strings
    hash = {
      "b" => "value2",
      "a" => "value1",
    }
    css = Property.new("property1", hash)
    assert_equal @result, css.to_s
  end

  def test_initialize_with_hash_of_symbols
    hash = {
      :b => "value2",
      :a => "value1",
    }
    css = Property.new("property1", hash)
    assert_equal @result, css.to_s
  end
end
