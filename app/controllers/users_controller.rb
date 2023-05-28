class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  
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
    # @user = current_user
    @users = User.find(params[:id]) 
    @book = Book.new 
    @books = @users.books 
  end

  def edit
    # is_matching_login_user ビフォーアクションで実行するため
    @user = User.find(params[:id]) 
  end
  
  def update
    # is_matching_login_user
    
    @user = User.find(params[:id]) 
    @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
  end
  
  private

  def book_params 
    params.require(:book).permit(:title, :body, :user_id) 
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end 
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
  end
  
end
