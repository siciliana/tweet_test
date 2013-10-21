class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :username
      t.string :location
      t.string :name
      t.string :description
      t.datetime :user_created_at

      t.timestamps
    end
  end
end