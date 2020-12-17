Rails.application.routes.draw do
  root "application#index"
  namespace :admin do
    resources :articles, only: %i[index destroy]
    # get '/articles', to: 'admin/articles#index'
  end
  namespace "api" do
    resources :articles, only: %i[index]
  end
  scope "/:locale" do
    post 'favorite', to: 'articles#favorite'
    post 'articles/draft', to: 'articles#draft_create'
    patch 'articles/draft', to: 'articles#draft_update'
    get 'login', to: 'users#login'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    post 'change_locale', to: 'application#change_locale'
    resources :articles
    get 'mypage', to: 'users#mypage'
    patch 'update/password', to: 'users#password_update'
    resources :users, only: %i[new create edit update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
