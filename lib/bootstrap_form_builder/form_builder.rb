module BootstrapFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def text_field(attribute, options = {}, &block)
      input_tag = block_given? ? capture(super, &block) : super
      field(input_tag, attribute, options)
    end

    def password_field(attribute, options = {}, &block)
      input_tag = block_given? ? capture(super, &block) : super
      field(input_tag, attribute, options)
    end

    def file_field(attribute, options = {}, &block)
      input_tag = block_given? ? capture(super, &block) : super
      field(input_tag, attribute, options)
    end

    def collection_select(attribute, collection, value_method, text_method, options = {}, html_options = {})
      select_tag = super
      field(select_tag, attribute, options)
    end

    def select(attribute, choices, options = {}, html_options = {}, &block)
      select_tag = super
      field(select_tag, attribute, options)
    end

    def time_zone_select(attribute, priority_zones = nil, options = {}, html_options = {})
      select_tag = super
      field(select_tag, attribute, options)
    end

    def uneditable_field(attribute, options = {})
      options[:class] = options[:class] ? "#{options[:class]} uneditable-input" : 'uneditable-input'
      options[:id] = "#{object.class.model_name.underscore}_#{attribute}"
      span_tag = content_tag(:span, object.send(attribute), options)
      field(span_tag, attribute, options)
    end

    def submit(value = nil, options = {})
      # This version of #submit differs slightly from the ActionView version in that
      # the model name is titleized to maintain consistent capitalization, e.g., for
      # a model named QuoteRequest the button label is "Create Quote Request" rather
      # than "Create Quote request".
      value ||= "#{object.new_record? ? 'Create' : 'Update'} #{object.class.model_name.titleize}"
      button_class = ['btn', *options.delete(:class)].join(' ')
      content_tag :div, class: 'clearfix' do
        content_tag :div, class: 'actions' do
          super(value, options.merge(class: button_class))
        end
      end
    end

    def field(input_tag, attribute, options)
      errors = object.errors[attribute].uniq.to_sentence
      outer_class = errors.blank? ? 'clearfix' : 'clearfix error'
      inner_class = errors.blank? ? 'input' : 'input error'

      content_tag(:div, id: "#{object.class.model_name.underscore}_#{attribute}_input", class: outer_class) do
        label(attribute, options[:label]) << content_tag(:div, class: inner_class) do
          input_div = input_tag
          input_div << content_tag(:span, options[:hint], class: 'help-block') if options[:hint]
          input_div << content_tag(:span, errors, class: 'help-inline') if errors.present?
          input_div
        end
      end
    end

    delegate :content_tag, :capture, to: :@template
  end
end
