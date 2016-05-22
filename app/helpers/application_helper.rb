module ApplicationHelper

  def cablush_description
    "Cablush é um site colaborativo, para te ajudar a encontrar lojas, eventos e lugares onde praticar o seu esporte favorito."
  end

  def cablush_keywords
    "cablush,esporte,esportes,esportista,radical,outdoor,sport,sports,skate,skateboarding,sk8,longboard,longboarding,longboarder,patins,patinador,roller,rollerblade,inline,bike,bicicleta,bmx,mountain bike,mtb,local,loja,pista,evento,eventos,campeonato"
  end

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

  def meta_tags(url, title, description, image)
    content_for :meta_tags do
      tag(:meta, property: "og:url", content: "#{url}") +
      tag(:meta, property: "og:title", content: "#{title}") +
      tag(:meta, property: "og:description", content: "#{description}") +
      tag(:meta, property: "og:image", content: "#{image}")
    end
  end

end
