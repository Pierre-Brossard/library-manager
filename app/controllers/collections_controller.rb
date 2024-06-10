class CollectionsController < ApplicationController
  before_action :set_collection, only: [:update, :favorite]

  def update
    @collection.update(collection_params)
    redirect_to book_path(@collection.book)
  end

  def create
    @book = Book.find(params[:book_id])
    Collection.create(book: @book, user: current_user)
  end

  def destroy
    @collection = Collection.find_by(book_id: params[:id], user_id: current_user)
    @collection.destroy
    redirect_to books_path
  end

  def favorite
    @collection.is_favorited = !@collection.is_favorited

    if @collection.save
      render json: {message: 'The favorite status has been updated'}, status: :accepted
    else
      render json: {error: 'temporary error message'}, status: :unprocessable_entity
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:comment)
  end

  def set_collection
    @collection = Collection.find(params[:id])
  end
end
