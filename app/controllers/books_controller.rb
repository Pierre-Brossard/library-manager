class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.find_by(title: book_params[:title])

    unless @book
      @book = Book.new(book_params)
      render :new, status: :unprocessable_content unless @book.save
    end

    @collection = Collection.new(user: current_user, book: @book)
    if @collection.save
      redirect_to new_book_path
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def book_params
    params.require(:book).permit(
      :book_type,
      :title,
      :author,
      :illustrator,
      :serie_id,
      :serie_number,
      :description,
      :release,
      :edition
    )
  end
end
