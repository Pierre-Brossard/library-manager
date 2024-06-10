class CollectionsController < ApplicationController

  def update
    @collection = Collection.find(params[:id])
    @collection.update(collection_params)
    redirect_to book_path(@collection.book)
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
