class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def sign_in_user(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def sign_out_user
    session[:user_id] = nil
    @current_user = nil
  end
end
