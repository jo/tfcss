module Css
  # The Value holds a CSS value and a references to its parent Property 
  # (which references its parent Element, which itself references its parent Stylesheet)
  class Value
    attr_reader :value, :unit, :property
  
    UNITS = %w{pt pc in mm cm px em ex %}
    VALUES = {
      'background-repeat' => %w{no-repeat repeat repeat-x repeat-y},
      'clear' => %w{none both left right},
      'display' => %w{none block inline},
      'float' => %w{none left right},
      'font-weight' => %w{normal bold bolder lighter},
      'font-variant' => %w{normal small-caps},
      'font-style' => %w{normal italic oblique},
      'font-family' => ['sans-serif', 'serif', 'monospace', 'Verdana, sans-serif', 'Times, serif'],
      'font-' => %w{normal },
      'list-styl-type' => %w{none square bullet circle},
      'position' => %w{absolute relative},
      'text-align' => %w{left center justify right},
      'text-decoration' => %w{none underline},
    }
  
    # Creates a new Value by value and parent property.
    def initialize(value = '', property = Property.new)
      @property = property
      if value.kind_of?(Array)
        @value = value.join('')
      elsif value.kind_of?(Hash)
        if value.keys.all? { |k| k.respond_to?(:<=>) }
          @value = value.keys.sort.map { |k| value[k] }.join
        elsif value.keys.all? { |k| k.kind_of?(Symbol) }
          @value = value.keys.map { |k| k.to_s }.sort.map { |k| value[k.to_sym] }.join
        else
          @value = value.values.join
        end
      else
        @value = value
      end
      return unless @value
      @value = @value.strip
      if @value =~ /[\d\.]+(#{UNITS.join('|')})$/
        @unit = @value.gsub(/^[\d\.]+(#{UNITS.join('|')})$/, '\1')
        @value.gsub!(/(#{UNITS.join('|')})$/, '')
      end
      @unit ||= 'px' if @value == '0'
    end

    # returns the position of the value.
    def index
      property.values.index(self)
    end
  
    def choices
      return unless property
      VALUES[property.name]
    end

    def color?
      false unless property
      property.name =~ /color/ || property.name == 'background' && index == 0
    end
  
    def image?
      false unless property
      property.name =~ /image/ || property.name == 'background' && index == 1
    end
  
    # Returns a String representation of the value.
    # That is just the value.
    def to_s
      [value, unit].join
    end
  end
end
