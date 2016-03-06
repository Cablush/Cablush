Cablush::Application.routes.draw do
  
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"
  
  devise_for :usuarios, controllers: { 
      registrations: 'usuario/registrations', 
      sessions: 'usuario/sessions', 
      passwords: 'usuario/passwords' ,
      omniauth_callbacks: 'usuario/omniauth_callbacks'
  }
  
  # API
  namespace :api do
      mount_devise_token_auth_for 'Usuario', at: 'auth', controllers: {
          registrations: 'api/registrations'
      }, skip: [:omniauth_callbacks]
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
  
  # CADASTRO
  namespace :cadastros do
    resources :lojas, param: :uuid do
      get :autocomplete_esporte_nome, on: :collection
      get :autocomplete_cidade_nome, on: :collection
    end
    resources :eventos, param: :uuid do
      get :autocomplete_esporte_nome, on: :collection
      get :autocomplete_cidade_nome, on: :collection
    end
    resources :pistas, param: :uuid do
      get :autocomplete_esporte_nome, on: :collection
      get :autocomplete_cidade_nome, on: :collection
    end
  end
  
  # PESQUISA
  resources :lojas, only: [:index, :show], param: :uuid
  resources :eventos, only: [:index, :show], param: :uuid
  resources :pistas, only: [:index, :show], param: :uuid
  
  resources :contacts, only: [:index, :create]
  
  match "index", to: "home#index", via: [:get]
  match "contact", to: "contacts#index", via: [:get]
  match "about", to: "home#about", via: [:get]
  match "cadastros", to: "home#cadastros", via: [:get]
  
  # You can have the root of your site routed with "root"
  root 'home#index'

end
