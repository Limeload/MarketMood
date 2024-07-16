# services/twitter_service.rb
require 'rest-client'
require 'json'
require 'sentimental'

class TwitterService
  BASE_URL = 'https://api.twitter.com/2/tweets/search/recent'

  def self.get_tweets(query)
    params = {
      'query' => query,
      'max_results' => 100,
      'tweet.fields' => 'created_at,lang',
      'expansions' => 'author_id',
      'user.fields' => 'username'
    }
    headers = { 'Authorization' => "Bearer #{ENV['TWITTER_BEARER_TOKEN']}" }
    response = RestClient.get(BASE_URL, { params: params, headers: headers })
    JSON.parse(response.body)
  end

  def self.analyze_sentiment(tweets)
    analyzer = Sentimental.new
    analyzer.load_defaults
    tweets.map do |tweet|
      {
        text: tweet['text'],
        sentiment: analyzer.sentiment(tweet['text']),
        score: analyzer.score(tweet['text'])
      }
    end
  end
end
