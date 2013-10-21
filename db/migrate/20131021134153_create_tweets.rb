class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.datetime :authored_date
      t.integer :twitter_id, :limit => 8
      t.references :twitter_user

      t.timestamps
    end
  end
end
