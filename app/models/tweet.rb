class Tweet < ActiveRecord::Base
  class << self
    def cached_tweets(twitter_handle)
      Tweet.where(screen_name: twitter_handle)
    end

    def cache_and_return_tweets(api_tweets)
      Tweet.where(screen_name: api_tweets.first.user.screen_name).destroy_all
      api_tweets.map do |tweet|
        Tweet.create(text: tweet.text,
                     tweet_created_at: tweet.created_at.to_datetime,
                     screen_name: tweet.user.screen_name)
      end
    end

    def within_five_minutes?(twitter_handle)
      tweets = Tweet.where(screen_name: twitter_handle)
      return false if tweets.empty?
      return true if tweets.first.created_at.to_datetime > 5.minutes.ago
      false
    end
  end
end
