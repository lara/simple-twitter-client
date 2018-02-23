class TwitterService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def tweet(status)
    client.update(status)
  end

  def fetch_tweets
    client.user_timeline(user.uid.to_i)
  end

  private

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_API_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_API_SECRET")
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end
  end
end
