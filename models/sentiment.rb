# models/sentiment.rb
class Sentiment
  attr_accessor :text, :sentiment, :score

  def initialize(text, sentiment, score)
    @text = text
    @sentiment = sentiment
    @score = score
  end
end
