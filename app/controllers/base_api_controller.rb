class BaseApiController < ApplicationController
  before_action :authenticate_user_from_token
  attr_reader :current_user

  private

  def authenticate_user_from_token
    @current_user = params[:token].presence && User.find_or_create_by(token: params[:token])
    render(json: { error: { message: 'Invalid Credentials', code: 401} }, status: 401) unless @current_user
  end

  def render_error(errors)
    render json: { error: { message: errors, code: 422 } }, status: 422
  end
end
