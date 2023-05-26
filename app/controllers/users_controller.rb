class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    
  end
  
  def create
    @book = Book.new(book_params) 
    @book.user_id = current_user.id 
    @book.save 
    redirect_to books_path 
  end
  
  def show
    @user = current_user
    @users = User.find(params[:id]) 
    @book = Book.new 
    @books = @user.books 
  end

  def edit
    @user = User.find(params[:id]) 
  end
  
  private

  def book_params 
    params.require(:book).permit(:title, :body, :user_id) 
  end
  
end
