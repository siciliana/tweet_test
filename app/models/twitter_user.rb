class TwitterUser < ActiveRecord::Base
  has_many :tweets


  def fetch_tweets!
    tweets = Twitter.user_timeline("#{self.username}")[0..9]
    tweets.each do |tweet|
      Tweet.where(:twitter_id => tweet.id).first_or_create(
        :text => tweet.text,
        :authored_date => tweet.created_at,
        :twitter_user_id => self.id)
    end
    # self.tweets.limit(10)
  end

  def tweets_stale?
    latest_tweet = self.tweets.first.authored_date
    diff = Time.now - latest_tweet
    true if diff/60 > 15
  end

  def cached_tweets
    self.tweets.limit(10)
  end

  def bieber_tweets
  	bieber_tweets = Twitter.search("to:justinbieber marry me", :count => 3, :result_type => "recent").results.map do |status|
  "#{status.from_user}: #{status.text}"
end
  end 


end