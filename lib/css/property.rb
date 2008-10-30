module Css
  # Holds one Css Property.
  # The Property has a reference to its parent Element (which references its parent Stylesheet).
  # The Property has an Array of Value.
  class Property
    attr_reader :name, :value, :element, :values
  
    # Creates a new Property by name, value and parent Element.
    # The value can be a String or Array containing the values of that Property.
    def initialize(name, value, element)
      @name = name.strip
      @value = value
      @element = element
      @values = []
      if value.kind_of?(Array)
        value.each do |n|
          add_value n
        end
      elsif value.kind_of?(String) && value.strip != ""
        value.strip.split(/\s+/).each do |v|
          add_value v
        end
      else
        add_value ""
      end
    end
  
    # Adds a value by name to the values array
    def add_value(name)
      @values << Value.new(name, self)
    end
  
    # Returns a String representation of the Property as plain CSS.
    def to_s
      "  %s: %s;" % [name, values.map { |e| e.to_s }.join(" ").gsub(/ (pt|pc|in|mm|cm|px|em|ex|%)/, '\1')]
    end
  end
end
