class TwitterService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def tweet(status)
    client.update(status)
    store_timeline
  end

  def tweets_from_timeline
    client.user_timeline(user.uid.to_i, count: 200)
  end

  def store_timeline
    tweets_from_timeline.each do |tweet|
      begin
        save_tweet(tweet)
      rescue
        break
      end
    end
  end

  def save_tweet(tweet)
    Tweet.create(
      tid: tweet.id,
      text: tweet.full_text,
      url: tweet.url,
      user_id: user.id,
    )
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
