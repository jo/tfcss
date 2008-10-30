module Css
  # The Stylesheet is similar to a whole css file.
  # The value is parsed into an Array of Element, each with an Array of Property and Value on initialisation.
  class Stylesheet
    attr_reader :elements
  
    # Creates a new Stylesheet by name and value.
    # Value can be a String or Hash.
    def initialize(value = {})
      @elements = []
      if value.kind_of?(Hash)
        value.each do |n, v|
          add_element n, v
        end
      elsif value.kind_of?(String) && value.strip != ''
        value.strip.gsub(/\/\*.*?\*\//m, '').split(/[}]\n*/).each do |entry|
          add_element entry.gsub(/\{.*$/m, '').strip, entry.gsub(/.*\{/m, '').strip
        end
      end
    end
  
    # Adds an Element to the Stylesheet.
    # Look for the existing ones.
    # If the Element is already present, we merge the properties.
    def add_element(name, value)
      return if name == ''
      legacy = find_element(name)
      if legacy
        legacy.merge Element.new(name, value, self)
      else
        @elements << Element.new(name, value, self)
      end
    end
  
    # Finds an element by name.
    def find_element(name)
      @elements.find { |e| e.name == name }
    end
  
    # Returns a String representation of the Stylesheet.
    # The output is just plain CSS.
    def to_s
      elements.map { |e| e.to_s }.join("\n")
    end
  end
end
