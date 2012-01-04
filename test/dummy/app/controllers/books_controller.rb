class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new.tap { |b| b.build_author }
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to @book, notice: 'Book created!'
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      redirect_to @book, notice: 'Book updated!'
    else
      render 'edit'
    end
  end

  def destroy
    Book.destroy(params[:id])
    redirect_to books_url, notice: 'Book destroyed!'
  end
end
