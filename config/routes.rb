Rails.application.routes.draw do
  get 'register', to: 'sessions#register'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end
  root to: 'sessions#top'

  resources :interviews do
    member do
      get 'apply'
      get 'cancel'
    end
  end

  resources :events do
    member do
      get 'apply'
      get 'cancel'
      get 'cancel_request'
      get 'punch_in'

    end
    collection do
      get 'manager'
      get 'datelist'
      get 'entries'
      get 'payments'
      get 'payments/:year/:month' => 'events#list',
        :constraints => { :year => /\d{4}/, :month => /\d{2}/ }
      get ':year/:month/:day' => 'events#date',
        :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ }
    end
  end
  
  resource :account, only:[:show, :edit, :update]

  resource :registration, only:[:new, :create]

  resources :password_resets do
    collection do
      get 'sent'
    end
  end
  
end
