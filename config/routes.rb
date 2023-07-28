Rails.application.routes.draw do
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
    resources :post_comments, only: [:destroy]
  end

  # 顧客用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'

    resources :reviews
    resources :games, only: [:show,:create]
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]

    # users/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get  '/users/information' => 'users#show'
    get  '/users/information/edit' => 'users#edit'
    patch  '/users/information' => 'users#update'
    get  '/users/unsubscribe' => 'users#unsubscribe'
    patch  '/users/withdraw' => 'users#withdraw'
    get 'games_search' => 'games#search'
    patch '/reviews/:id/edit' => 'reviews#update'
  end
end