# services/sentiment_service.rb
class SentimentService
  def self.get_combined_sentiment(ticker)
    news_data = NewsService.get_news(ticker)
    tweets_data = TwitterService.get_tweets(ticker)
    {
      news_sentiment: analyze_news_sentiment(news_data['results']),
      twitter_sentiment: TwitterService.analyze_sentiment(tweets_data['data'])
    }
  end

  def self.analyze_news_sentiment(news_articles)
    analyzer = Sentimental.new
    analyzer.load_defaults
    news_articles.map do |article|
      {
        title: article['title'],
        sentiment: analyzer.sentiment(article['description']),
        score: analyzer.score(article['description'])
      }
    end
  end
end
