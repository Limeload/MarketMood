# services/notification_service.rb
class NotificationService
  def self.send_alert(user, ticker, score)
    # Implement email or SMS notification
    puts "Alert for #{user.username}: #{ticker} sentiment score reached #{score}"
  end
end
