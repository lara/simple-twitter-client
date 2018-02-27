class StoreTimelineService
  attr_reader :client, :user
  attr_accessor :page

  def initialize(client, user)
    @client = client
    @user = user
    @page = 1
  end

  def store
      loop do
        begin
          begin
            save_tweets
          rescue ActiveRecord::RecordNotUnique
            break
          end
          self.page += 1
          break if tweets.empty?
        rescue Twitter::Error::TooManyRequests => error
          sleep error.rate_limit.reset_in + 1
        end
      end
  end

  def save_tweets
    tweets.each(&method(:save_tweet))
  end

  def tweets
    client.user_timeline(user.uid.to_i, count: 2, page: page, tweet_mode: "extended")
  end

  def save_tweet(tweet)
    Tweet.create(
      tid: tweet.id,
      text: tweet.attrs[:full_text],
      url: tweet.url,
      user_id: user.id,
    )
  end
end
