class BooksController < ApplicationController
  def index
    @book = Book.new
    @user = current_user 
    @books = Book.all
  end

  def create
    @book = Book.new(book_params) 
    @book.user_id = current_user.id 
    @book.save 
    redirect_to books_path 
  end

  def edit
  end

  def show
  end

  private

  def book_params 
    params.require(:book).permit(:title, :body, :user_id) 
  end
end
