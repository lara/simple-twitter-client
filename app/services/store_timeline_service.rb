class StoreTimelineService
  attr_reader :client, :user

  def initialize(client, user)
    @client = client
    @user = user
  end

  def store
    page = 1
      loop do
        begin
          tweets = client.user_timeline(user.uid.to_i, count: 2, page: page)
          begin
            tweets.each(&method(:save_tweet))
          rescue ActiveRecord::RecordNotUnique
            break
          end
          page += 1
          break if tweets.empty?
        rescue Twitter::Error::TooManyRequests => error
          sleep error.rate_limit.reset_in + 1
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
end
