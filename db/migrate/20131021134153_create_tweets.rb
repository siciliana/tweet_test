class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.datetime :tweet_time
      t.string :text
      t.string :twitter_tweet_id
      t.integer :twitter_user_id

      t.timestamps
    end
  end
end