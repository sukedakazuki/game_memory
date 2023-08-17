# frozen_string_literal: true

Rails.application.routes.draw do
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "top" => "homes#top", as: "top"
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
  end

  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: "homes#top"

    resources :games, only: [:show, :create]
    resources :reviews do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    # users/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get  "/users/information" => "users#show"
    get  "/users/information/edit" => "users#edit"
    patch "/users/information" => "users#update"
    get "/users/unsubscribe" => "users#unsubscribe"
    patch "/users/withdraw" => "users#withdraw"

    get "search" => "searches#search"
    get "games_search" => "games#search"
    patch "/reviews/:id/edit" => "reviews#update"
    get "search_tag" => "reviews#search_tag"
    
    get "rank" => "ranks#rank"
  end
end
