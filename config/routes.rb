Rails.application.routes.draw do
  root to: 'works#index'
  resources :works
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
