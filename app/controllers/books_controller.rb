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
    @books = Book.find(params[:id])
  end
  
  def update
    @books = Book.find(params[:id])
    @books.update(book_params)
    redirect_to book_path(@books.id)
    
  end

  def show
    @book = Book.new
    # @user = current_user
    @books = Book.find(params[:id]) 
    # @users = @books.user.id
    @users = User.find_by(id: @books.user_id)
  end
  
  def destroy
    books = Book.find(params[:id]) 
    books.destroy 
    redirect_to books_path
  end

  private

  def book_params 
    params.require(:book).permit(:title, :body, :user_id) 
  end
end
