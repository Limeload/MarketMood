# helpers/application_helper.rb
module ApplicationHelper
  def format_date(date)
    date.strftime("%B %d, %Y")
  end

  def format_score(score)
    score.round(2)
  end
end
