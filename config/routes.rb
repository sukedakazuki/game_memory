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
    get '/about' => 'homes#about'
    
    resources :reviews, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    end
    
    get 'users/mypage' => 'users#show', as: 'mypage'
    # users/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    put 'users/information' => 'users#update'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
    
    get 'games/search'
  end
end