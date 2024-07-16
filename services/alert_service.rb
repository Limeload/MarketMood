# services/alert_service.rb
class AlertService
  def self.create_alert(user, ticker, threshold)
    Alert.create(user: user, ticker: ticker, threshold: threshold)
  end

  def self.check_alerts
    Alert.all.each do |alert|
      sentiment = SentimentService.get_combined_sentiment(alert.ticker)
      combined_score = (sentiment[:news_sentiment].map { |s| s[:score] }.sum + sentiment[:twitter_sentiment].map { |s| s[:score] }.sum) / (sentiment[:news_sentiment].size + sentiment[:twitter_sentiment].size)
      if combined_score >= alert.threshold
        NotificationService.send_alert(alert.user, alert.ticker, combined_score)
      end
    end
  end
end
