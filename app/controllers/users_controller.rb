class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    
  end
  
  def create
    # @book = Book.new(book_params) 
    # @book.user_id = current_user.id 
    # @book.save 
    # redirect_to books_path 
    @book = Book.new(book_params) 
    @book.user_id = current_user.id 
    if @book.save 
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end 
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
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit 
    end
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
      redirect_to user_path(current_user) 
    end
  end
  
end
