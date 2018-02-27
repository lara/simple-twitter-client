class StaticPagesController < ApplicationController
  def index
    render locals: { tweets: tweets }
  end

  private

  def tweets
    return nil unless current_user
    current_user.tweets.page params[:page]
  end
end
