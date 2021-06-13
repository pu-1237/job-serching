Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end
  root to: 'sessions#top'
  resources :events do
    member do
      get 'apply'
      get 'cancel'
      get 'cancel_request'
      get 'punch_in'

    end
    collection do
      get 'list'
      get 'datelist'
      get 'applicant'
      get ':year/:month/:day' => 'events#date',
        :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ }
      

    end
  end
end
