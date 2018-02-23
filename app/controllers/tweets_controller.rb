class TweetsController < ApplicationController
  def create
    TwitterService.new(current_user).tweet(params[:tweet][:text])
    redirect_to root_path
  rescue Twitter::Error::Forbidden
    flash[:error] = "Your tweet is too long!"
  end
end
