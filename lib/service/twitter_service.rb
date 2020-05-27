# frozen_string_literal: true

require 'twitter'

class TwitterService
  TTL = 300.seconds
  STALE_TTL = 86400.seconds

  def self.fetch_user_timeline
    tweets = Rails.cache.fetch('user_timeline', expires_in: TTL) do
      client.user_timeline(username, {:count => 5, :exclude_replies => true}).collect do |tweet|
        tweet_model = Tweet.new(tweet)
        {
          text: tweet.text,
          full_text: tweet.full_text,
          uri: tweet.uri.to_s,
          created_at: tweet.created_at,
          created_at_string: tweet_model.smart_timestamp,
          linkified_text: tweet_model.linkified_text,
          user_name: tweet_model.user_details[:name],
          user_uri: 'http://www.twitter.com/' + tweet_model.user_details[:screen_name],
          user_screen_name: tweet_model.user_details[:screen_name],
          user_avatar_url: tweet_model.user_details[:avatar_url],
        }
      end
    end

    unless tweets.nil?
      Rails.cache.write('stale_user_timeline', tweets, expires_in: STALE_TTL)
    end

    tweets || []
  rescue
    Rails.logger.error($!)
    Rails.cache.fetch('stale_user_timeline') || []
  end

private

  def self.client
    @@client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = 'REDUCTED'
      config.consumer_secret     = 'REDUCTED'
      config.access_token        = 'REDUCTED'
      config.access_token_secret = 'REDUCTED'
    end
  end

  def self.username
    'bbcrd'
  end
end
