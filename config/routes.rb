Rails.application.routes.draw do
  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks',
  registrations: 'users/registrations'
  }
  
  root to: "posts#index"
  
  #フォローユーザーとフォロワーを取得できるようにネスト
  resources :users do
    get "following" => "users#following"
    get "followers" => "users#followers"
  end
  get 'users/:id' => "users#show_ather"
  resources :relationships, only: [:create, :destroy]

  resources :posts do
    post "likes" => "likes#create"
    delete "likes" => "likes#destroy"
    post "comments" => "comments#create"

  end
  resources :comments, only: [:destroy]
  get 'items/search', to: "items#search"
  resources :items, only: [:destroy, :update]
  
end
