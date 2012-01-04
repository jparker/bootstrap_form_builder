require 'test_helper'

class BootstrapFormBuilderTest < ActiveSupport::TestCase
  include ActionView::Helpers
  include BootstrapFormBuilder::Helpers

  attr_accessor :output_buffer

  def protect_against_forgery?() end

  class ::Book
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    attr_accessor :title

    def persisted?() end
  end

  def books_path(*args) '/books' end

  setup do
    @output_buffer = ''
    @book = Book.new
    concat(bootstrap_form_for(@book) { |f| concat(f.text_field(:title)) })
  end

  test '#text_field outputs a div with Bootstrap-friendly styling' do
    assert_match %r{<div class="clearfix" id="book_title_input">}, output_buffer
  end

  test '#text_field outputs a label tag' do
    assert_match %r{<label for="book_title">Title</label>}, output_buffer
  end

  test '#text_field outputs an input tag' do
    assert_match %r{<div class="input"><input id="book_title" name="book\[title\]" size="30" type="text" /></div>}, output_buffer
  end
end
