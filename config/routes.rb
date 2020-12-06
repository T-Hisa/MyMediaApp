Rails.application.routes.draw do
  root 'articles#index'
  resources :articles
  resources :users, only: %i[create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
