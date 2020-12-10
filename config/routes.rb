Rails.application.routes.draw do
  root to: redirect("/#{I18n.locale}/articles")
  scope "/:locale" do
    get 'login', to: 'users#login'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    post 'change_locale', to: 'application#change_locale'
    resources :articles
    get 'mypage', to: 'users#mypage'
    patch 'update/password', to: 'users#password_update'
    resources :users, only: %i[new create edit update]
    namespace :admin do
      resources :articles
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
