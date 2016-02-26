# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.cablush.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  
  # Register pages
  add new_usuario_session_path, priority: 0.7, changefreq: 'monthly'
  add new_usuario_registration_path, priority: 0.7, changefreq: 'monthly'
  add new_usuario_password_path, priority: 0.7, changefreq: 'monthly'
  
  # Main pages
  add about_path, priority: 0.5, changefreq: 'monthly'
  add contact_path, priority: 0.5, changefreq: 'monthly'
  add eventos_path, priority: 0.9, changefreq: 'always'
  add lojas_path, priority: 0.9, changefreq: 'always'
  add pistas_path, priority: 0.9, changefreq: 'always'
  
  # Dynamic pages
  Evento.find_each do |evento|
    add evento_path(evento), lastmod: evento.updated_at, priority:0.8, changefreq: 'never'
  end
  Loja.find_each do |loja|
    add loja_path(loja), lastmod: loja.updated_at, priority:0.8, changefreq: 'never'
  end
  Pista.find_each do |pista|
    add pista_path(pista), lastmod: pista.updated_at, priority:0.8, changefreq: 'never'
  end
  
  # Authenticated pages
#  add cadastros_path, priority: 0.6, changefreq: 'monthly'
#  add cadastros_eventos_path, priority: 0.6, changefreq: 'monthly'
#  add cadastros_lojas_path, priority: 0.6, changefreq: 'monthly'
#  add cadastros_pistas_path, priority: 0.6, changefreq: 'monthly'
  
end

# SitemapGenerator::Sitemap.ping_search_engines
