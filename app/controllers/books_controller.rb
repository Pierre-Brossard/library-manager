require 'open-uri'

class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def show
    @collection = Collection.find_by(book_id: @book.id)
  end

  def index
    @books = current_user.books
    if params[:query].present?
      # @books = PgSearch.multisearch(params[:query]).map {|doc| doc.searchable }.reject {|searchable| searchable.instance_of? Serie }
      @books = Book.global_search(params[:query])
    end

    respond_to do |format|
      format.html
      format.text { render partial: "partials/index_list", locals: {books: @books}, formats: [:html] }
    end
  end

  def new
    unless params[:title]
      @book = @book || Book.new
      @book.genres.build
    else
      @book = Book.find_by(isbn: params[:isbn])
      unless @book
        @book = Book.create!(
          book_type: 'Roman',
          title: params[:title],
          author: params[:author],
          release: Date.new(params[:release].to_i),
          edition: params[:edition],
          isbn: params[:isbn],
          cover_url: params[:cover_url]
        )
        @book.serie = Serie.create_or_find_by!(name: params[:serieNames][0])
        image = open(params[:cover_url])
        @book.cover_img.attach(io: image, filename: "#{params[:title]}_cover_image", content_type: "image/jpg")
        # Un seul genre est ajouté pour l'instant, ne sachant pas le format de genres multiples
        genre = Genre.find_or_create_by!(name: params[:genres])
        BookGenre.create!(book: @book, genre: genre)
        # params[:genres].each do |genre_name|
        #   genre = Genre.find_or_create_by!(name: genre_name)
        #   BookGenre.create!(book: @book, genre: genre)
        # end
      end
    end

    respond_to do |format|
      format.html
      format.text { render partial: "partials/books/book_card_choice",
        locals: {book: @book, collection: Collection.new},
        formats: [:html] }
    end

  end

  def create
    raise
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
