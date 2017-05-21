class HomeController < ApplicationController
  def index
  end

  private

  helper_method :videos
  def videos
    @_videos ||= current_user.videos
  end
end
