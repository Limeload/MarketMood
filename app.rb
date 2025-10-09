# app.rb
require 'sinatra'
require 'rest-client'
require 'json'
require 'sentimental'
require 'sidekiq'
require_relative 'services/news_service'
require_relative 'services/twitter_service'
require_relative 'services/sentiment_service'
require_relative 'services/alert_service'

# Configure Sidekiq
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

# Load API keys
require_relative 'config/api_keys' # Ensure POLYGON_API_KEY and TWITTER_BEARER_TOKEN are defined here

# Enable sessions for user authentication
enable :sessions

# Home page
get '/' do
  erb :dashboard
end

# News route
get '/news' do
  @news = NewsService.get_news
  erb :news
end

# Sentiment analysis route
get '/sentiment/:ticker' do
  @sentiment = SentimentService.get_combined_sentiment(params[:ticker])
  erb :sentiment
end

# Alerts routes
post '/alerts' do
  user = User.find(session[:user_id])
  AlertService.create_alert(user, params[:ticker], params[:threshold])
  redirect '/alerts'
end

get '/alerts' do
  @alerts = User.find(session[:user_id]).alerts
  erb :alerts
end

# Error handling for API request limit
error RestClient::TooManyRequests do
  erb :error
end
