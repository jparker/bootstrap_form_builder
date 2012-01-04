require 'test_helper'

class BootstrapFormBuilder::HelpersTest < ActionView::TestCase
  test '#bootstrap_form_for calls form_for with a builder option' do
    view.expects(:form_for).with(anything, has_entry(:builder, BootstrapFormBuilder::FormBuilder))
    view.bootstrap_form_for(stub_everything) {}
  end

  test '#bootstrap_form_for passes other options through to form_for' do
    view.expects(:form_for).with(anything, has_entries(builder: BootstrapFormBuilder::FormBuilder, method: :put))
    view.bootstrap_form_for(stub_everything, method: :put) {}
  end

  test '#bootstrap_fields_for calls fields_for with a builder option' do
    view.expects(:fields_for).with(anything, has_entry(:builder, BootstrapFormBuilder::FormBuilder))
    view.bootstrap_fields_for(stub_everything) {}
  end
end
