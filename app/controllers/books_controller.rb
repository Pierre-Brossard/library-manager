class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def show
    @collection = Collection.find_by(book_id: @book.id)
  end

  def index
    @books = Book.all

    if params[:query].present?
      @books = Book.global_search(params[:query])
    end

    unless (params[:my].present? && params[:my] == 'false')
      @books = @books.with_user_id(current_user.id)
    end

    if params[:genres].present? && params[:genres] != ""
      @books = @books.filtered_by_genre(params[:genres].split(' '))
    end

    @books = @books.includes(:serie, :cover_img_blob)
    @genres = Genre.all
    respond_to do |format|
      format.html
      format.text { render partial: "partials/index_list", locals: {books: @books}, formats: [:html] }
    end
  end

  def new
    @book = @book || Book.new
    @book.genres.build
  end

  def create
    # je vérifie si le livre existe déjà avec son titre
    @book = Book.find_by(title: book_params[:title])

    # si le livre n'existe pas, je tente de créer un nouveau livre
    unless @book
      @book = Book.new(book_params)
      @book.release = Date.new(book_params[:release].to_i)

      # je tente de créer la série voulue par l'auteur
      if serie_params[:name] != ''
        @serie = Serie.create_or_find_by!(serie_params)
        @book.serie = @serie
      end

      # si je ne peux pas enregistrer le livre,
      @book.save
    end

    # je crée une nouvelle collection entre l'utilisateur et le book qui vient d'être créer
    if @book.id
      # je crée les associations livre - genre
      params[:book][:genre_ids][1..].each do |genre_id|
        BookGenre.create!(book: @book, genre_id: genre_id.to_i)
      end

      @collection = Collection.new(user: current_user, book: @book)
      if @collection.save
        redirect_to new_book_path
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def serie_params
    params.require(:serie).permit(:name)
  end

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
