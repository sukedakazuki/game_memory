Rails.application.routes.draw do
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
  end

  # 顧客用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'

    resources :games, only: [:show,:create]
    resources :reviews do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    # users/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get  '/users/information' => 'users#show'
    get  '/users/information/edit' => 'users#edit'
    patch  '/users/information' => 'users#update'
    get  '/users/unsubscribe' => 'users#unsubscribe'
    patch  '/users/withdraw' => 'users#withdraw'
    
    get "search" => "searches#search"
    get 'games_search' => 'games#search'
    patch '/reviews/:id/edit' => 'reviews#update'
  end
end