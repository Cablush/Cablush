Cablush::Application.routes.draw do
  
  require 'sidekiq/web'
  
  mount Sidekiq::Web, at: "/sidekiq"
  
  devise_for :usuarios, :controllers => { registrations: 'registrations' }
  
  resources :lojas
  resources :eventos
  resources :pistas
  
  #get :autocomplete_local_nome, :on => :collection
  
  resources :contacts
  
  match "home/lojas", via: [:get, :post]
  match "home/eventos", via: [:get, :post]
  match "home/pistas", via: [:get, :post]
  match "home/cadastros", via: [:get, :post]
  
  get "home/index"
  get "home/index_admin"
  
  get "home/about"
  get "home/blog"
  
  # You can have the root of your site routed with "root"
  root 'home#index'

end
