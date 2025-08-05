Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by uptime monitors and load balancers.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dashboard#index"

  # Learning resources routes
  resources :courses do
    resources :chapters
    resources :videos
    resources :labs
    member do
      patch :update_progress
    end
  end

  # Individual completion routes
  resources :chapters, only: [:show, :edit, :update, :destroy] do
    member do
      patch :complete
    end
  end
  
  resources :videos, only: [:show, :edit, :update, :destroy] do
    member do
      patch :complete
    end
  end
  
  resources :labs, only: [:show, :edit, :update, :destroy] do
    member do
      patch :complete
    end
  end

  resources :books do
    resources :chapters
    member do
      patch :update_progress
      get :viewer
    end
  end

  resources :articles do
    member do
      patch :update_progress
    end
  end

  # Calendar and todos
  resources :calendar_events
  resources :todos do
    member do
      patch :toggle_complete
    end
  end

  # Notes system
  resources :notes do
    member do
      patch :move
    end
  end

  # Dashboard
  get 'dashboard', to: 'dashboard#index'
  get 'progress', to: 'dashboard#progress'
end
