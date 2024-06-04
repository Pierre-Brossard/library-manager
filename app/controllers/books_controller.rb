class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    # je vérifie si le livre existe déjà avec son titre
    @book = Book.find_by(title: book_params[:title])

    # si le livre n'existe pas, je tente de créer un nouveau livre
    unless @book
      @book = Book.new(book_params)
      @book.release = Date.new(book_params[:release].to_i)
      unless @book.save
        render :new, status: :unprocessable_entity
      end
    end

    # je crée une nouvelle collection entre l'utilisateur et le book qui vient d'être créer
    @collection = Collection.new(user: current_user, book: @book)
    if @collection.save
      redirect_to new_book_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @books = current_user.books
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
      :edition,
      :cover_img
    )
  end
end
