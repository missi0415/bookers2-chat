Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  # , :controllers => {
  #   :registrations => 'users/registrations'
  # }
  
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  
  resources :books, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy] 
    resources :book_comments, only: [:create, :destroy]
  end
  #フォロー機能  
post 'follow/:id' => 'relationships#follow', as: 'follow' 
post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' 
  resources :users do
    member do
     get :following, :followers
    end
  end
  get '/search' => 'search#search'
end