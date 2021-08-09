Rails.application.routes.draw do
  devise_for :users
  
  root to: "posts#index"
  
  resources :users

  resources :posts do
    post "likes" => "likes#create"
    delete "likes" => "likes#destroy"
    post "comments" => "comments#create"
    delete "comments" => "comments#destroy"
  end
  
  
  
end
