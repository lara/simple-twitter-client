class TwitterService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def tweet(status)
    client.update(status)
    store_timeline
  end

  def store_timeline
    StoreTimelineJob.new.perform(client, user)
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
