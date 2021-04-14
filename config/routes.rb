Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  namespace :admin do
    resources :users
  end
  root to: 'calendars#index'
  resources :works do
    member do
      get 'apply'
      get 'cancel'
    end
  end

  resources :calendars
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
