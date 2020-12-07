Rails.application.routes.draw do
  root to: redirect('articles')
  get 'login', to: 'users#login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :articles
  get 'mypage', to: 'users#mypage'
  resources :users, only: %i[new create edit update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
