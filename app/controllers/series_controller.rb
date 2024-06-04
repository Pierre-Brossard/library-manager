class SeriesController < ApplicationController

  def index
    @user_favorite_series = current_user.series
  end
end
