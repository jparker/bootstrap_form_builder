require 'bootstrap_form_builder/form_builder'
require 'bootstrap_form_builder/helpers'

ActionView::Base.class_eval do
  include BootstrapFormBuilder::Helpers
end
