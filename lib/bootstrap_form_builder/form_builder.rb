module BootstrapFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def text_field(attribute, options = {}, &block)
      input_tag = block_given? ? template.capture(super, &block) : super
      label_tag = label(attribute, options.delete(:label))
      field(attribute, input_tag, label_tag)
    end

    def collection_select(attribute, collection, value_method, text_method, options = {})
      select_tag = super
      label_tag = label(attribute, options.delete(:label))
      field(attribute, input_tag, label_tag)
    end

    def commit(options = {})
      options[:class] = options[:class] ? "#{options[:class]} btn" : 'btn'
      text = "#{object.new_record? ? 'Create' : 'Update'} #{object.class.model_name.humanize}"
      template.content_tag :div, class: 'actions' do
        submit(text, options)
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
