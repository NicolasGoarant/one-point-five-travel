Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  # Static pages
  get "about",        to: "pages#about"
  get "methodology",  to: "pages#methodology"

  # Countries with climate scores
  resources :countries, only: [:index, :show], param: :slug do
    member do
      get :climate_details
    end
  end

  # Trip scoring
  resources :trips, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :score_breakdown
    end
    collection do
      post :calculate_preview
    end
  end

  # Destinations
  resources :destinations, only: [:index, :show], param: :slug do
    resources :accommodations, only: [:index, :show]
  end

  # API endpoints for AJAX scoring
  namespace :api do
    namespace :v1 do
      resources :scores, only: [] do
        collection do
          post :calculate
          get  :country_ranking
        end
      end
      resources :countries, only: [:index, :show], param: :iso_code
      resources :transport_modes, only: [:index]
    end
  end

  # User dashboard
  resource :dashboard, only: [:show], controller: "dashboard"

  # Admin namespace
  namespace :admin do
    root "dashboard#index"
    resources :countries, except: [:destroy]
    resources :climate_data_imports, only: [:new, :create, :index]
    resources :destinations
  end

  # Health check
  get "up", to: "rails/health#show", as: :rails_health_check

  get "pourquoi", to: "pages#pourquoi"

  get "carte", to: "pages#carte"

end
