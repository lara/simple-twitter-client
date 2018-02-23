class StaticPagesController < ApplicationController
  def index
    render locals: { tweets: tweets }
  end

  private

  def tweets
    return nil unless current_user
    TwitterService.new(current_user).fetch_tweets
  end
end
