module BootstrapFormBuilder
  module Helpers
    def bootstrap_form_for(*args, &block)
      options = args.extract_options!
      form_for(*args, options.merge(builder: BootstrapFormBuilder::FormBuilder), &block)
    end

    def bootstrap_fields_for(*args, &block)
      options = args.extract_options!
      fields_for(*args, options.merge(builder: BootstrapFormBuilder::FormBuilder), &block)
    end
  end
end
