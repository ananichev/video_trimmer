class BaseApiController < ApplicationController
  before_action :authenticate_user_from_token

  private

  def authenticate_user_from_token
    @current_user = params[:token].presence && User.find_or_create_by(token: params[:token])
    render(json: { error: { message: 'Invalid Credentials', code: 401} }, status: 401) unless @current_user
  end

  helper_method :current_user

  def current_user
    @current_user
  end
end
