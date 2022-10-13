Rails.application.routes.draw do
  get 'register', to: 'sessions#register'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'tops#index'

  namespace :admin do
    resources :users
  end

  resources :users do
    resources :images, controller: "user_images"
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
      get ':year/:month/:day' => 'events#date',
        :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ }
    end
  end
  
  resources :accounts do
    collection do
      get 'entries'
      get 'payments'
      get 'payments/:year/:month' => 'accounts#list',
      :constraints => { :year => /\d{4}/, :month => /\d{2}/ }
      get '/:id' => 'accounts#index',
      :constraints => { :id => /\d+/ }
    end
  end

  resource :registration do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
  end

  resources :password_resets do
    collection do
      get 'sent'
    end
  end
  
end
