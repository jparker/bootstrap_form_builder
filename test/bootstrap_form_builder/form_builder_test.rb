require 'test_helper'

class BootstrapFormBuilder::FormBuilderTest < ActiveSupport::TestCase
  include ActionView::Helpers
  include BootstrapFormBuilder::Helpers

  attr_accessor :output_buffer

  def protect_against_forgery?() end

  class ::Book
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    attr_accessor :author_id, :title, :genre, :passphrase, :time_zone

    def persisted?() end
  end

  def books_path(*args) '/books' end

  setup do
    @output_buffer = ''
    @book = Book.new
  end

  test '#text_field outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.text_field(:title)) })
    assert_match output_buffer, %r{<div class="clearfix" id="book_title_input">}
  end

  test '#text_field outputs a label tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.text_field(:title)) })
    assert_match output_buffer, %r{<label for="book_title">Title</label>}
  end

  test '#text_field outputs an input tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.text_field(:title)) })
    assert_match output_buffer, %r{<div class="input"><input id="book_title" name="book\[title\]" size="30" type="text" /></div>}
  end

  test '#text_field with hint option outputs a help block' do
    concat(bootstrap_form_for(@book) { |f| concat(f.text_field(:title, hint: 'The Hobbit')) })
    assert_match output_buffer, %r{<span class="help-block">The Hobbit</span>}
  end

  test '#text_field with errors wraps field in error class' do
    @book.errors.stubs(:[]).returns(["can't be blank"])
    concat(bootstrap_form_for(@book) { |f| concat(f.text_field(:title)) })
    assert_match output_buffer, %r{<div class="clearfix error" id="book_title_input">}
    assert_match output_buffer, %r{<div class="input error">}
    assert_match output_buffer, %r{<span class="help-inline">can't be blank</span>}
  end

  test '#password_field outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.password_field(:passphrase)) })
    assert_match output_buffer, %r{<div class="clearfix" id="book_passphrase_input">}
  end

  test '#password_field outputs a label tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.password_field(:passphrase)) })
    assert_match output_buffer, %r{<label for="book_passphrase">Passphrase</label>}
  end

  test '#password_field outputs an input tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.password_field(:passphrase)) })
    assert_match output_buffer, %r{<div class="input"><input id="book_passphrase" name="book\[passphrase\]" size="30" type="password" /></div>}
  end

  test '#file_field outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.file_field(:attachment)) })
    assert_match output_buffer, %r{<div class="clearfix" id="book_attachment_input">}
  end

  test '#file_field outputs a label tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.file_field(:attachment)) })
    assert_match output_buffer, %r{<label for="book_attachment">Attachment</label>}
  end

  test '#file_field outputs an input tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.file_field(:attachment)) })
    assert_match output_buffer, %r{<div class="input"><input id="book_attachment" name="book\[attachment\]" type="file" /></div>}
  end

  test '#collection_select outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.collection_select(:author_id, [], :id, :name)) })
    assert_match output_buffer, %r{<div class="clearfix" id="book_author_id_input">}
  end

  test '#collection_select outputs a label tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.collection_select(:author_id, [], :id, :name)) })
    assert_match output_buffer, %r{<label for="book_author_id">Author</label>}
  end

  test '#collection_select outputs a select tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.collection_select(:author_id, [], :id, :name)) })
    assert_match output_buffer, %r{<div class="input"><select id="book_author_id" name="book\[author_id\]"></select></div>}
  end

  test '#select outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.select(:genre, [])) })
    assert_match output_buffer, %r{<div class="clearfix" id="book_genre_input">}
  end

  test '#select outputs a label tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.select(:genre, [])) })
    assert_match output_buffer, %r{<label for="book_genre">Genre</label>}
  end

  test '#seelct outputs a select tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.select(:genre, [])) })
    assert_match output_buffer, %r{<div class="input"><select id="book_genre" name="book\[genre\]"></select></div>}
  end

  test '#time_zone_select outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.time_zone_select(:time_zone)) })
    assert_match output_buffer, %r{<div class="clearfix" id="book_time_zone_input">}
  end

  test '#time_zone_select outputs a label tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.time_zone_select(:time_zone)) })
    assert_match output_buffer, %r{<label for="book_time_zone">Time zone</label>}
  end

  test '#time_zone_select outputs a select tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.time_zone_select(:time_zone)) })
    assert_match output_buffer, %r{<div class="input"><select id="book_time_zone" name="book\[time_zone\]">(?:<option value=".*">.*</option>\n?)+</select></div>}
  end

  test '#submit outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.submit) })
    assert_match output_buffer, %r{<div class="clearfix"><div class="actions">}
  end

  test '#submit outputs a submit button' do
    concat(bootstrap_form_for(@book) { |f| concat(f.submit) })
    assert_match output_buffer, %r{<input class="btn" name="commit" type="submit" value="Create Book" />}
  end

  test '#submit applies provided class to button' do
    concat(bootstrap_form_for(@book) { |f| concat(f.submit(nil, class: 'primary')) })
    assert_match output_buffer, %r{<input class="btn primary" .* />}
  end

  test '#uneditable_field outputs a clearfix div' do
    concat(bootstrap_form_for(@book) { |f| concat(f.uneditable_field(:title)) })
    assert_match output_buffer, %r{<div class="clearfix" id="book_title_input">}
  end

  test '#uneditable_field outputs a label tag' do
    concat(bootstrap_form_for(@book) { |f| concat(f.uneditable_field(:title)) })
    assert_match output_buffer, %r{<label for="book_title">Title</label>}
  end

  test '#uneditable_field outputs a span tag with class uneditable-input' do
    concat(bootstrap_form_for(@book) { |f| concat(f.uneditable_field(:title)) })
    assert_match output_buffer, %r{<div class="input"><span class="uneditable-input" id="book_title"></span></div>}
  end
end
