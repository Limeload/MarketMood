# models/news.rb
class News
  attr_accessor :title, :description, :url

  def initialize(title, description, url)
    @title = title
    @description = description
    @url = url
  end
end
