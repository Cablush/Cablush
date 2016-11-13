Cablush::Application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  require 'sidekiq/web'

  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :usuarios, controllers: {
    registrations: 'usuario/registrations',
    sessions: 'usuario/sessions',
    passwords: 'usuario/passwords',
    omniauth_callbacks: 'usuario/omniauth_callbacks'
  }

  # API
  namespace :api do
    devise_scope :usuario do
      match 'usuarios/sign_in', to: '/usuario/sessions#create', via: [:post]
      match 'usuarios/sign_out', to: '/usuario/sessions#destroy', via: [:delete]
      match 'usuarios/validate_token',
            to: '/usuario/sessions#validate_token',
            via: [:get]
      match 'usuarios', to: '/usuario/registrations#create', via: [:post]
      match 'usuarios', to: '/usuario/registrations#update', via: [:patch, :put]
      match 'usuarios/password', to: '/usuario/passwords#create', via: [:post]
      match 'usuarios/auth/facebook/validate_token',
            to: '/usuario/omniauth_callbacks#validate_facebook_token',
            via: [:get, :post]
      match 'usuarios/auth/google_oauth2/validate_token',
            to: '/usuario/omniauth_callbacks#validate_google_token',
            via: [:get, :post]
    end
    resources :lojas, only: [:index, :show, :create, :update],
                      param: :uuid, defaults: { format: 'json' } do
      get :mine, on: :collection
      post :upload, on: :member
    end
    resources :pistas, only: [:index, :show, :create, :update],
                       param: :uuid, defaults: { format: 'json' } do
      get :mine, on: :collection
      post :upload, on: :member
    end
    resources :eventos, only: [:index, :show, :create, :update],
                        param: :uuid, defaults: { format: 'json' } do
      get :mine, on: :collection
      post :upload, on: :member
    end
    resources :esportes, only: [:index], defaults: { format: 'json' }
  end

  # CADASTRO
  namespace :cadastros do
    resources :lojas, param: :uuid
    resources :eventos, param: :uuid
    resources :pistas, param: :uuid
    resources :campeonatos, param: :uuid do
      post :evento, on: :member
      scope module: 'campeonatos' do
        resources :participantes, param: :uuid
        resources :etapas, param: :uuid do
          post :generate, on: :collection
        end
      end
    end
  end

  # AUTOCOMPLETE
  resources :esportes, only: [] do
    get :autocomplete_esporte_nome, on: :collection
  end
  resources :locais, only: [] do
    get :autocomplete_cidade_nome, on: :collection
  end

  # PESQUISA
  resources :lojas, only: [:index, :show], param: :uuid
  resources :campeonatos, only: [:index, :show], param: :uuid
  resources :eventos, only: [:index, :show], param: :uuid
  resources :pistas, only: [:index, :show], param: :uuid

  resources :contacts, only: [:index, :create]

  match 'index', to: 'home#index', via: [:get]
  match 'contact', to: 'contacts#index', via: [:get]
  match 'about', to: 'home#about', via: [:get]
  match 'cadastros', to: 'home#cadastros', via: [:get]

  # ERRORS
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # You can have the root of your site routed with 'root'
  root 'home#index'
end
