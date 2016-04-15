module ApplicationHelper
  
  def full_title(page_title)
    base_title = "Cablush"
    if page_title.blank?
      base_title
    else
      "#{base_title} | .: #{page_title} :."
    end
  end
  
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
  
  def is_active(route, by_verb = false)
    if by_verb 
      'active' if request.path.try(:ends_with?, route)
    else
      'active' if request.path.try(:starts_with?, route)
    end
  end
  
  def locais_to_json(locais)
    raw locais.to_json(
      :except => [:id, :created_at, :updated_at, :localizavel_id], 
      :include => {:localizavel => { 
        :except => [:id, :created_at, :updated_at, :responsavel_id], 
      }})
  end
  
end
