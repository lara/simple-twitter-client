class SessionsController < ApplicationController
  def create
    sign_in
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def sign_in
    session[:user_id] = user.id
    TwitterService.new(user).store_tweets
  end

  def sign_out
    session[:user_id] = nil
    @current_user = nil
  end

  def user
    find_user || sign_up
  end

  def find_user
    User.find_by(uid: auth[:uid])
  end

  def sign_up
    User.create(
      name: auth[:info][:name],
      uid: auth[:uid],
      oauth_token: auth[:credentials][:token],
      oauth_secret: auth[:credentials][:secret],
      picture: auth[:info][:image],
    )
  end

  def auth
    request.env["omniauth.auth"]
  end
end
