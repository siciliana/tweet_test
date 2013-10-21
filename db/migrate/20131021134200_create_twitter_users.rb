class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :name
      t.string :screen_name
      t.string :description
      t.datetime :last_queried

      t.timestamps
    end
  end
end