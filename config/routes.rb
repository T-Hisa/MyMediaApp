Rails.application.routes.draw do
  get 'login', to: 'users#login'
  post 'login', to: 'sessions#create'
  root 'articles#index'
  resources :articles
  resources :users, only: %i[new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
