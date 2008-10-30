module Css
  # Holds one Css Element with an Array of its Property, each with an Array of Value.
  # Also keeping a reference to the parent Stylesheet.
  class Element
    attr_reader :name, :properties, :stylesheet
  
    # Creates a new Element by name, value and stylesheet.
    # Value can be a String or a Hash, containing the properties of that element.
    def initialize(name, value, stylesheet)
      @name = name.strip
      @stylesheet = stylesheet
      @properties = []
      if value.kind_of?(Hash)
        value.each do |n, v|
          add_property n, v
        end
      elsif value.kind_of?(String) && value.strip != ""
        value.strip.split(/;/).each do |property|
          add_property property.gsub(/:.*$/m, "").strip, property.gsub(/^.*:/m, "").strip
        end
      end
    end
  
    # Merge an Element with another.
    # Adds all properties of the other element
    # and overrides existing ones.
    def merge(other)
      other.properties.each do |property|
        add_property(property.name, property.value)
      end
    end
  
    # Add a property to the Array of properties.
    # If the property already exists, its values will be overwritten.
    def add_property(name, value)
      return if name == ""
      legacy = find_property(name)
      if legacy
        legacy.values = Property.new(name, value, self).values
      else
        @properties << Property.new(name, value, self)
      end
    end
  
    # Finds a property by name.
    def find_property(name)
      @properties.find { |p| p.name == name }
    end
  
    # Returns a textual representation of the Element as plain CSS.
    def to_s
      "%s {\n%s\n}" % [name, properties.map { |p| p.to_s }.join("\n")]
    end
  end
end
