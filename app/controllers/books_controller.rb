class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  
  def index
    @book = Book.new
    @user = current_user 
    @books = Book.all
  end

  def create
    @user = current_user 
    @books = Book.all 
    @book = Book.new(book_params) 
    @book.user_id = current_user.id 
    if @book.save 
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def edit
    @books = Book.find(params[:id])
  end
  
  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@books.id)
    else
      render :edit
    end 
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
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
end
