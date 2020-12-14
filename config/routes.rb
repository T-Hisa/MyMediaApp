Rails.application.routes.draw do
  post 'comments', to: 'comments#create'
  delete 'comments', to: 'comments#destory'
  namespace :admin do
    resources :articles, only: %i(index destroy)
    # get '/articles', to: 'admin/articles#index'
  end
  scope "/:locale" do
    root "articles#index"
    get 'login', to: 'users#login'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    post 'change_locale', to: 'application#change_locale'
    post 'favorite', to: 'articles#favorite'
    resources :articles do
      resources :commments, only: %i(create destroy)
    end
    get 'mypage', to: 'users#mypage'
    patch 'update/password', to: 'users#password_update'
    resources :users, only: %i[new create edit update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
