module ApplicationHelper

  def full_title(page_title)
    base_title = "Cablush"
    if page_title.blank?
      base_title
    else
      second_title = page_title.gsub(/<\/?[^>]*>/, "")
      "#{base_title} | .: #{second_title} :."
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

  def meta_tags(url, title, description, image)
    content_for :meta_tags do
      tag(:meta, property: "og:url", content: "#{url}") +
      tag(:meta, property: "og:title", content: "#{title}") +
      tag(:meta, property: "og:description", content: "#{description}") +
      tag(:meta, property: "og:image", content: "#{image}")
    end
  end

end
