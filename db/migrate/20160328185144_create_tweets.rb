class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.datetime :tweet_created_at
      t.string :screen_name
      t.timestamps
    end
  end
end
