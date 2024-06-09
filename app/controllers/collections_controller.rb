class CollectionsController < ApplicationController

  def update
    Collection.update(collection_params)
    redirect_to book_path(params[:id])
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

  private

  def collection_params
    params.require(:collection).permit(:comment)
  end
end
