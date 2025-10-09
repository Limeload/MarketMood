# services/news_service.rb
require 'rest-client'
require 'json'

class NewsService
  BASE_URL = 'https://api.polygon.io/v2/reference/news'

  def self.get_news(ticker = nil)
    params = { apiKey: ENV['POLYGON_API_KEY'] }
    params[:ticker] = ticker if ticker
    response = RestClient.get(BASE_URL, { params: params })
    JSON.parse(response.body)
  end
end
