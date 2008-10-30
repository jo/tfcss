module Css
  # Holds one Css Property.
  # The Property has a reference to its parent Element (which references its parent Stylesheet).
  # The Property has an Array of Value.
  class Property
    attr_reader :name, :element, :values
  
    # Creates a new Property by name, value and parent Element.
    # The value can be a String or Array containing the values of that Property.
    # Or the value can be a Hash. In this case, the values are created in order of their sorted keys.
    def initialize(name = '', value = {}, element = Element.new)
      @name = name.strip
      @value = value
      @element = element
      @values = []
      if value.kind_of?(Array)
        value.each do |n|
          add_value n
        end
      elsif value.kind_of?(Hash)
        if value.keys.all? { |k| k.respond_to?(:<=>) }
          value.keys.sort.each do |k|
            add_value value[k]
          end
        elsif value.keys.all? { |k| k.kind_of?(Symbol) }
          value.keys.map { |k| k.to_s }.sort.each do |k|
            add_value value[k.to_sym]
          end
        else
          value.each do |k, v|
            add_value v
          end
        end
      elsif value.kind_of?(String) && value.strip != ''
        value.strip.split(/\s+/).each do |v|
          add_value v
        end
      else
        add_value
      end
    end
  
    # Adds a value by name to the values array
    def add_value(name = '')
      @values << Value.new(name, self)
    end
  
    # Returns a String representation of the Property as plain CSS.
    def to_s
      '  %s: %s;' % [name, values.join(' ')]
    end
  end
end
