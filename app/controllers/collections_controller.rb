class CollectionsController < ApplicationController

  def update
    Collection.update(collection_params)
    redirect_to book_path(params[:id])
  end

  private

  def collection_params
    params.require(:collection).permit(:comment)
  end
end
