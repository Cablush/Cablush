Cablush::Application.routes.draw do
  
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"
  
  devise_for :usuarios, controllers: { registrations: 'registrations' }
  
  namespace :api do
      mount_devise_token_auth_for 'Usuario', at: 'auth', controllers: {
          sessions: 'api/sessions',
          registrations: 'api/registrations'
      }
      resources :lojas, only: [:index, :create, :update], defaults: { format: 'json' } do
        get :mine, on: :collection
      end
      resources :pistas, only: [:index, :create, :update], defaults: { format: 'json' } do
        get :mine, on: :collection
      end
      resources :eventos, only: [:index, :create, :update], defaults: { format: 'json' } do
        get :mine, on: :collection
      end
      resources :esportes, only: [:index], defaults: { format: 'json' }
  end
  
  resources :lojas do 
    get :autocomplete_esporte_nome, on: :collection
    get :autocomplete_cidade_nome, on: :collection
  end
  resources :eventos do 
    get :autocomplete_esporte_nome, on: :collection
    get :autocomplete_cidade_nome, on: :collection
  end
  resources :pistas do 
    get :autocomplete_esporte_nome, on: :collection
    get :autocomplete_cidade_nome, on: :collection
  end
  
  resources :contacts, only: [:index, :new, :create]
  
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
