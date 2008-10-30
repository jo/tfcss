module Css
  # The Value holds a CSS value and a references to its parent Property 
  # (which references its parent Element, which itself references its parent Stylesheet)
  class Value
    attr_reader :value, :unit, :property
  
    UNITS = %w{pt pc in mm cm px em ex %}
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
  
    # Creates a new Value by value and parent property.
    def initialize(value = '', property = Property.new)
      @value = value.strip
      if value =~ /\d+(#{UNITS.join('|')})$/
        @unit = @value.gsub(/^\d+(#{UNITS.join('|')})$/, '\1')
        @value.gsub!(/(#{UNITS.join('|')})$/, '')
      end
      @property = property
    end
  
    # Returns the type of the value.
    # Try to fetch it from the TYPES hash by property's value and the index of the current value from property's values.
    # Returns :text if none was found.
    def type
      TYPES[property.value][property.values.index(self)]
    rescue => e
      :text
    end
  
    # Returns a String representation of the value.
    # That is just the value.
    def to_s
      [value, unit].join
    end
  end
end
