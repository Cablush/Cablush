module ApplicationHelper
  def full_title(page_title)
    base_title = "Cablush"
    if page_title.blank?
      base_title
    else
      "#{base_title} | .: #{page_title} :."
    end
  end
end
