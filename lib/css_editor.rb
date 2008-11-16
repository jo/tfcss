module CssEditor 
  class ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormOptionsHelper

    def css_editor(attribute, options = {})
      object = @template.instance_variable_get("@#{self.object_name}")
      stylesheet self.object_name, attribute, object.send(attribute), object, options
    end

    private

    def stylesheet(object_name, attribute, stylesheet, object, options)
      [
        content_tag(:a, 'Experten', :href => '?expert=true', :class => :expert),
        stylesheet.elements.map { |e| element(object_name, attribute, e, object, options) }.join("\n")
      ].join("\n")
    end

    def element(object_name, attribute, element, object, options)
      content_tag :fieldset, content_tag(:legend, display(element.name)) + element.properties.map { |p| property(object_name, attribute, p, options) }.join("\n")
    end

    def property(object_name, attribute, property, options)
      content_tag :p, [
        content_tag(:label, display(property.name)),
        property.values.map { |v| value(object_name, attribute, v, object, options) }.join("\n"),
      ].join("\n")
    end

    def value(object_name, attribute, value, object, options)
      names = [object_name, attribute, value.property.element.id, value.property.id, value.index]
      name = '%s[%s][%s][%s][%d]' % names
      id = names.join('_')
      out = []
      if value.color?
        form_id = ['edit', object_name, object.id].join('_')
        out << content_tag(:input, nil, :name => '%s[0]' % name, :id => '%s_0' % id, :class => "colorpicker", :value => value.value, :size => 5)
        img = content_tag(:img, nil, :src => "/images/picker.png")
        out << content_tag(:a, img, :class => :picker, :onclick => "javascript:TCP.popup(document.forms['edit_#{object_name}_#{object.id}'].elements['#{'%s_0' % id}'])")
      elsif value.image?
        out << content_tag(:select, options_for_select(options[:images], value.value), :name => '%s[0]' % name, :id => '%s_0' % id)
      elsif value.choices
        out << content_tag(:select, options_for_select(value.choices.map { |c| [display(c), c] }, value.value), :name => '%s[0]' % name, :id => '%s_0' % id)
      else
        out << content_tag(:input, nil, :name => '%s[0]' % name, :id => '%s_0' % id, :value => value.value, :size => 5)
      end
      unless value.unit.blank?
        out << content_tag(:select, options_for_select(Css::Value::UNITS.map { |c| [display(c), c] }, value.unit), :name => '%s[1]' % name, :id => '%s_1' % id)
      end
      out.join("\n")
    end

    NAMES = {
      '' => '',
      '' => '',
      '' => '',
      'a' => 'Link',
      'absolute' => 'Absolut',
      'acronym' => 'Abkürzung',
      'active' => 'Aktiv',
      'background' => 'Hintergrund',
      'background-position' => 'Hintergrund Position (horizonatal/vertikal)',
      'benefits' => 'Nutzen',
      'block' => 'Block',
      'body' => 'Körper',
      'bold' => 'Fett',
      'bolder' => 'extrafett',
      'border' => 'Rahmen',
      'both' => 'Beide',
      'bottom' => 'Unten',
      'center' => 'Mittig',
      'class' => 'Klasse',
      'clear' => 'Stopp',
      'color' => 'Farbe',
      'container' => 'Container',
      'content' => 'Inhalt',
      'display' => 'Anzeigeart',
      'div' => 'Box',
      'min' => 'Minimale',
      'explanation' => 'Erklährung',
      'family' => 'Familie',
      'float' => 'Fluss',
      'font' => 'Schrift',
      'font-weight' => 'Schriftstärke',
      'footer' => 'Fuss',
      'h1' => '1.Überschrift',
      'h2' => '2.Überschrift',
      'h3' => '3.Überschrift',
      'h4' => '4.Überschrift',
      'h5' => '5.Überschrift',
      'header' => 'Kopf',
      'height' => 'Höhe',
      'hover' => 'Berührt',
      'href' => 'Adresse',
      'html' => 'Seite',
      'id' => 'Id',
      'image' => 'Bild',
      'inline' => 'Im Fluss',
      'italic' => 'kursiv',
      'justify' => 'Blocksatz',
      'left' => 'Links',
      'letter-spacing' => 'Zeichenabstand',
      'li' => 'Listenelement',
      'lighter' => 'dünner',
      'link' => 'Link',
      'linkList' => 'Menu',
      'list-style-type' => 'Listenart',
      'main' => 'Alles',
      'margin' => 'Außenabstand',
      'no' => 'keine',
      'none' => 'Kein',
      'oblique' => 'schräggestellt',
      'ol' => 'Geordnete Liste',
      'overflow' => 'Überfluss',
      'p' => 'Absatz',
      'p1' => '1.Absatz',
      'p2' => '2.Absatz',
      'padding' => 'Innenabstand',
      'participation' => 'Beteiligung',
      'position' => 'Position',
      'preamble' => 'Präambel',
      'quickSummary' => 'Kurzzusammenfassung',
      'relative' => 'Relativ',
      'repeat' => 'Wiederholung',
      'right' => 'Rechts',
      'sidebar_left' => 'Seitenleiste links',
      'sidebar_right' => 'Seitenleiste rechts',
      'size' => 'Größe',
      'small-caps' => 'Kapitälchen',
      'span' => 'Element',
      'style' => 'Stil',
      'stylesheet' => 'Style',
      'supportingText' => 'Unterstützender Text',
      'text-align' => 'Ausrichtung',
      'text-decoration' => 'Schriftdekoration',
      'top' => 'Oben',
      'ul' => 'Ungeordnete Liste',
      'underline' => 'Unterstrichen',
      'variant' => 'Variante',
      'visited' => 'Besucht',
      'width' => 'Breite',
      'x' => 'horizontal',
      'y' => 'vertikal',
    }.freeze

    def display(text)
      h (NAMES[text] || text.gsub('-', ' ').split(/[\s,\.>\[\]="#:]/).map { |m| NAMES[m] || m }.join(' '))[0..53]
    end
  end
end
