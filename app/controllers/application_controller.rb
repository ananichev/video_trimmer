class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  private

  # It's just for web testing purposes
  helper_method :current_user
  def current_user
    @_current_user ||= User.find_or_create_by(token: 'simple_token')
  end
end
