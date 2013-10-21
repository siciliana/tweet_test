class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def tweets_stale?
    true
    # return true if self.last_queried == nil
    # if Time.now - self.last_queried > 900
    #   true
    # else
    #   false
    # end
  end

  def update_attributes!(tweet)
    self.name = tweet.user.name
    self.description = tweet.user.description
  end

  def update_tweets!(update_attrs = false)
    delete_tweets!
    returned_data = Twitter.user_timeline(self.screen_name, options={count: 10})
    
    update_attributes!(returned_data.last) if update_attrs

    returned_data.each do |tweet|
      self.tweets << Tweet.create(text: tweet.text, tweet_time: tweet.created_at, twitter_tweet_id: tweet.id)
    end
    self.last_queried = Time.now
    self.save
  end

  def get_new_tweets!
    if self.tweets.empty?
      p "This person has no tweets!"
      returned_data = Twitter.user_timeline(self.screen_name, options={count: 10})
    else
      p "let's get this person's latest tweets!"
      last_tweet_id = self.tweets.order("twitter_tweet_id").last.twitter_tweet_id

      p "here's my last tweet id !!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      p last_tweet_id
      returned_data = Twitter.user_timeline(self.screen_name, options={since_id: last_tweet_id})
    end

    tweets = []
    returned_data.each do |tweet|
      tweets << Tweet.create(text: tweet.text, tweet_time: tweet.created_at, twitter_tweet_id: tweet.id)
    end


    self.last_queried = Time.now
    self.tweets += tweets
    self.save

    tweets
  end


  def delete_tweets!
    self.tweets.each do |t|
      t.destroy
    end
    self.save
  end

end