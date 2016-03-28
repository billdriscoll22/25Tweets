class TweetsController < ApplicationController
  before_filter :authenticate_user!

  NUM_TWEETS = 25
  NUM_USERS = 3

  def index
  end

  def recent_tweets
    handle = params[:handle]
    if Tweet.within_five_minutes?(handle)
      @tweets = Tweet.cached_tweets(handle)
    else
      api_tweets = twitter_client.user_timeline(handle, count: NUM_TWEETS)
      @tweets = Tweet.cache_and_return_tweets(api_tweets)
    end
    render layout: false
  end

  def autocomplete
    @users = twitter_client.user_search(params[:term], count: NUM_USERS)
    render json: @users.map(&:screen_name)
  end

  private

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end
end
