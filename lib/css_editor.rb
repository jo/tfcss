module CssEditor 
  class ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormOptionsHelper

    def css_editor(attribute, options = {})
      object = @template.instance_variable_get("@#{self.object_name}")
      stylesheet self.object_name, attribute, object.send(attribute)
    end

    private

    def stylesheet(object_name, attribute, stylesheet)
      content_tag :fieldset, [
        content_tag(:a, 'Experten', :href => '?expert=true'),
        content_tag(:legend, h(attribute.to_s.humanize)),
        stylesheet.elements.map { |e| element(object_name, attribute, e) }.join("\n")
      ].join("\n")
    end

    def element(object_name, attribute, element)
      content_tag :fieldset, content_tag(:legend, h(element.name.humanize)) + element.properties.map { |p| property(object_name, attribute, p) }.join("\n")
    end

    def property(object_name, attribute, property)
      content_tag :p, [
        content_tag(:label, h(property.name.gsub('-', ' ').humanize)),
        property.values.map { |v| value(object_name, attribute, v) }.join("\n"),
      ].join("\n")
    end

    def value(object_name, attribute, value)
      names = [object_name, attribute, value.property.element.name, value.property.name, value.index]
      name = '%s[%s][%s][%s][%d]' % names
      id = names.join('_')
      out = []
      if value.choices
        out << content_tag(:select, options_for_select(value.choices, value.value), :name => '%s[0]' % name, :id => '%s_0' % id)
      else
        out << content_tag(:input, nil, :name => '%s[0]' % name, :id => '%s_0' % id, :value => value.value, :size => 5)
      end
      unless value.unit.blank?
        out << content_tag(:select, options_for_select(Css::Value::UNITS, value.unit), :name => '%s[1]' % name, :id => '%s_1' % id)
      end
      out.join("\n")
    end
  end
end
