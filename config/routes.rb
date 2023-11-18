require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#index"

  resources :posts do
    resource :like, only:[:show, :create, :destroy]
    resources :comments, only:[:index, :new, :create]
  end

  # userはdeviseが使用しているのでaccountに
  resources :accounts, only:[:show] do
    # accounts/:account_id/followsのPOSTでフォローの関係をつくる
    resources :follows, only:[:index, :create]
    # follows#destroyではなく、unfollows#createにする
    resources :unfollows, only:[:create]

    # フォロワーやフォローしている人の一覧ページ
    resources :followers, only:[:index]
    resources :followings, only:[:index]
  end

  resource :profile, only:[:show, :edit, :update]
end
