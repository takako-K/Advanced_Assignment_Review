Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # フォローフォロワー機能
  post 'create/:id' => 'relationships#create', as: 'follow'
  post 'destroy/:id' => 'relationships#destroy', as: 'unfollow'
  get 'follow_users' => 'users#follow_users'
  get 'follower_users' => 'users#follower_users'

end
