require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "uri"
require 'dotenv/load'

set :port, 3000

helpers do
  def fetch_finance_news
    finance_data = []
    finance_response = HTTP.get("https://api.stockdata.org/v1/news/all?symbols=TSLA,AMZN,MSFT&filter_entities=true&language=en&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")

    if finance_response.status.success?
      parsed_response = JSON.parse(finance_response.to_s)
      finance_data = parsed_response.fetch("data", [])
    else
      puts "Failed to fetch finance news: #{finance_response.status}"
    end

    finance_data
  end

  def fetch_stock_quote_data(symbols)
    stock_response = HTTP.get("https://api.stockdata.org/v1/data/quote?symbols=#{symbols}&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
    JSON.parse(stock_response.to_s).fetch("data", [])
  end

  def fetch_intraday_data(symbol)
    begin
      intraday_response = HTTP.get("https://api.stockdata.org/v1/data/intraday?symbols=#{symbol}&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
      JSON.parse(intraday_response.to_s).fetch("data", [])
    rescue HTTP::Error => e
      puts "Error fetching intraday data for #{symbol}: #{e.message}"
      []
    end
  end

  def fetch_eod_data(symbol)
    begin
      eod_response = HTTP.get("https://api.stockdata.org/v1/data/eod?symbols=#{symbol}&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
      JSON.parse(eod_response.to_s).fetch("data", [])
    rescue HTTP::Error => e
      puts "Error fetching EOD data for #{symbol}: #{e.message}"
      []
    end
  end

  def fetch_entity_search_data(search_term)
    stock_search = HTTP.get("https://api.stockdata.org/v1/entity/search?search=#{search_term}&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
    JSON.parse(stock_search.to_s).fetch("data", [])
  end

  def fetch_entity_type_list
    entity_type = HTTP.get("https://api.stockdata.org/v1/entity/type/list?api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
    JSON.parse(entity_type.to_s).fetch("data", [])
  end

  def fetch_industry_list
    industry_list = HTTP.get("https://api.stockdata.org/v1/entity/industry/list?api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
    JSON.parse(industry_list.to_s).fetch("data", [])
  end

  def fetch_positive_sentiment_news
    positive_response = HTTP.get("https://api.stockdata.org/v1/news/all?sentiment_gte=0.1&language=en&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
    JSON.parse(positive_response.to_s).fetch("data", [])
  end

  def fetch_neutral_sentiment_news
    neutral_response = HTTP.get("https://api.stockdata.org/v1/news/all?sentiment_gte=0&sentiment_lte=0&language=en&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
    JSON.parse(neutral_response.to_s).fetch("data", [])
  end

  def fetch_negative_sentiment_news
    negative_response = HTTP.get("https://api.stockdata.org/v1/news/all?sentiment_lte=-0.1&language=en&api_token=#{ENV.fetch("STOCK_DATA_KEY")}")
    JSON.parse(negative_response.to_s).fetch("data", [])
  end
end

get("/dashboard") do
  @finance_data = fetch_finance_news
  @stock_data = fetch_stock_quote_data("AAPL,TSLA,MSFT")
  @intraday_data = fetch_intraday_data("TSLA")  # Example symbol, replace with actual data
  @eod_data = fetch_eod_data("TSLA")            # Example symbol, replace with actual data
  @search_data = fetch_entity_search_data("tsla")
  @search_entity = fetch_entity_type_list
  @search_industry = fetch_industry_list
  @positive_data = fetch_positive_sentiment_news
  @neutral_data = fetch_neutral_sentiment_news
  @negative_data = fetch_negative_sentiment_news

  erb(:'skeleton/dashboard')
end

get("/news_content") do
  erb(:'data/news', layout: false)
end


