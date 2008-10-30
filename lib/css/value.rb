module Css
  # The Value holds a CSS value and a references to its parent Property 
  # (which references its parent Element, which itself references its parent Stylesheet)
  class Value
    attr_reader :name, :property
  
    TYPES = {
      'color' => [:color],
      'background' => [:color, :url, :repeat, :positiony, :positionx],
      'margin' => [:unit, :unit, :unit, :unit],
      'padding' => [:unit, :unit, :unit, :unit],
      'font' => [:fontstyle, :fontvariant, :fontweight, :unit, :fontfamily],
      'border' => [:unit, :borderstyle, :color],
      'display' => [:displaytype],
      'overflow' => [:overflows],
      'font-size' => [:unit],
      'height' => [:unit],
      'width' => [:unit],
      'min-height' => [:unit],
      'min-width' => [:unit],
      'list-style-type' => [:listtype],
      'line-height' => [:unit],
    }
  
    # Creates a new Value by name and parent property.
    def initialize(name = '', property = Property.new)
      @name = name.strip
      @property = property
    end
  
    # Returns the type of the value.
    # Try to fetch it from the TYPES hash by property's name and the index of the current value from property's values.
    # Returns :text if none was found.
    def type
      TYPES[property.name][property.values.index(self)]
    rescue => e
      :text
    end
  
    # Returns a String representation of the value.
    # That is just the name.
    def to_s
      name
    end
  end
end
