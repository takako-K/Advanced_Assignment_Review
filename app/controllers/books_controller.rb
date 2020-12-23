class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = current_user
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id), notice: "Book was successfully created."
    else
      @user = current_user
      render action: :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id), notice: "Book was successfully updated."
    else
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end


end

