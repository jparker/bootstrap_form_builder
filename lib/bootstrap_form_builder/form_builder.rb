module BootstrapFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def text_field(attribute, options = {}, &block)
      input_tag = block_given? ? template.capture(super, &block) : super
      label_tag = label(attribute, options.delete(:label))
      field(attribute, input_tag, label_tag)
    end

    def password_field(attribute, options = {}, &block)
      input_tag = block_given? ? template.capture(super, &block) : super
      label_tag = label(attribute, options.delete(:label))
      field(attribute, input_tag, label_tag)
    end

    def collection_select(attribute, collection, value_method, text_method, options = {})
      select_tag = super
      label_tag = label(attribute, options.delete(:label))
      field(attribute, select_tag, label_tag)
    end

    def uneditable_field(attribute, options = {})
      span_tag = template.content_tag(:span, object.send(attribute), class: 'uneditable-input', id: "#{object.class.model_name.underscore}_#{attribute}")
      label_tag = label(attribute, options.delete(:label))
      field(attribute, span_tag, label_tag)
    end

    def submit(value = nil, options = {})
      # This version of #submit differs slightly from the ActionView version in that
      # the model name is titleized to maintain consistent capitalization, e.g., for
      # a model named QuoteRequest the button label is "Create Quote Request" rather
      # than "Create Quote request".
      value ||= "#{object.new_record? ? 'Create' : 'Update'} #{object.class.model_name.titleize}"
      button_class = ['btn', *options.delete(:class)].join(' ')
      template.content_tag :div, class: 'clearfix' do
        template.content_tag :div, class: 'actions' do
          super(value, options.merge(class: button_class))
        end
      end
    end

    def field(attribute, input_tag, label_tag)
      errors = object.errors[attribute].uniq.to_sentence
      outer_class = errors.blank? ? 'clearfix' : 'clearfix error'
      inner_class = errors.blank? ? 'input' : 'input error'

      template.content_tag(:div, id: "#{object.class.model_name.underscore}_#{attribute}_input", class: outer_class) do
        label_tag << template.content_tag(:div, class: inner_class) do
          errors.blank? ? input_tag : input_tag << template.content_tag(:span, errors, class: 'help-inline')
        end
      end
    end

    private
    attr_reader :template
  end
end
