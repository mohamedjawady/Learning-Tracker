Rails.application.routes.draw do
  # Authentication routes
  get '/auth', to: 'auth#index', as: 'auth'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/signup', to: 'users#new'
  get '/register', to: 'users#new', as: 'register'
  post '/register', to: 'users#create'
  
  # User management
  resources :users, except: [:index]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by uptime monitors and load balancers.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dashboard#index"utes.draw do
  # Authentication routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/signup', to: 'users#new'
  get '/register', to: 'users#new', as: 'register'
  
  # User management
  resources :users, except: [:index]
  
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
