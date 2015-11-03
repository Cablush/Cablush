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
  
  def locais_to_json(locais)
    raw locais.to_json(
      :except => [:id, :created_at, :updated_at, :localizavel_id], 
      :include => {:localizavel => { 
        :except => [:id, :created_at, :updated_at, :responsavel_id], 
      }})
  end
  
end
