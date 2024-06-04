class SeriesController < ApplicationController

  def show
  end

  def index
    @user_favorite_series = current_user.series
  end
end
