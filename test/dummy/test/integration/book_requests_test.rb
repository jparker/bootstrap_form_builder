require 'test_helper'

class BookRequestsTest < ActionDispatch::IntegrationTest
  test 'GET /books/new renders the form' do
    get '/books/new'
    assert_select 'form[action=?]', books_path do
      assert_select 'div.clearfix#book_title_input' do
        assert_select 'label[for=book_title]', 'Title'
        assert_select 'input[type=text]#book_title'
      end
      assert_select 'div.clearfix#author_name_input' do
        assert_select 'label[for=book_author_attributes_name]', 'Author'
        assert_select 'input[type=text]#book_author_attributes_name'
      end
    end
  end
end
