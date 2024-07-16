# models/alert.rb
class Alert
  attr_accessor :user, :ticker, :threshold

  def initialize(user, ticker, threshold)
    @user = user
    @ticker = ticker
    @threshold = threshold
  end

  def self.create(user:, ticker:, threshold:)
    # Mocking alert creation. Replace with actual database logic.
    Alert.new(user, ticker, threshold)
  end

  def self.all
    # Mocking retrieval of all alerts. Replace with actual database logic.
    [
      Alert.new(User.new(1, "JaneDoe", "jane.doe@example.com"), "AAPL", 0.5),
      Alert.new(User.new(1, "JaneDoe", "jane.doe@example.com"), "TSLA", 0.7)
    ]
  end
end
