class SeriesController < ApplicationController

  def index
    @user_favorite_series = current_user.series
    @user_books_series = current_user.books_series
    @series = Serie.all
  end
end
