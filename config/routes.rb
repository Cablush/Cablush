Cablush::Application.routes.draw do
  
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"
  
  devise_for :usuarios, controllers: { registrations: 'registrations' }
  
  namespace :api do
      mount_devise_token_auth_for 'Usuario', at: 'auth', controllers: {
          registrations: 'api/registrations'
      }
      resources :lojas, only: [:index, :create, :update], 
                        param: :uuid, defaults: { format: 'json' } do
        get :mine, on: :collection
        post :upload, on: :member
      end
      resources :pistas, only: [:index, :create, :update], 
                         param: :uuid, defaults: { format: 'json' } do
        get :mine, on: :collection
        post :upload, on: :member
      end
      resources :eventos, only: [:index, :create, :update], 
                          param: :uuid, defaults: { format: 'json' } do
        get :mine, on: :collection
        post :upload, on: :member
      end
      resources :esportes, only: [:index], defaults: { format: 'json' }
  end
  
  namespace :cadastros do
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
  end
  
  resources :contacts, only: [:index, :create]
  
  match "index", to: "home#index", via: [:get]
  match "lojas", to: "lojas#search", via: [:get, :post]
  match "eventos", to: "eventos#search", via: [:get, :post]
  match "pistas", to: "pistas#search", via: [:get, :post]
  match "contact", to: "contacts#index", via: [:get]
  match "about", to: "home#about", via: [:get]
  match "cadastros", to: "home#cadastros", via: [:get, :post]
    
  # You can have the root of your site routed with "root"
  root 'home#index'

end
