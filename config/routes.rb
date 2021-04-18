Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  namespace :admin do
    resources :users
  end
  root to: 'events#index'
  resources :events do
    member do
      get 'apply'
      get 'cancel'
    end
    collection do
      get 'list'
      get 'datelist'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
