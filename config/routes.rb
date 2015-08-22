Rails.application.routes.draw do
  root :to => "static_pages#home"
  get "guest_session" => "session#guest"

  resources :users
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :leagues
    resources :teams
    resources :score_rules, only: [:update]
    resources :roster_rules, only: [:update]
    resources :roster_slots, only: [:update]
    resources :players, only: [:index, :show]
    resources :player_contracts, only: [:create, :destroy]
    resources :matchups, only: [:create, :index]
    resources :messages, only: [:create, :index, :show]
    resources :comments, only: [:create, :destroy]
    resources :trade_offers, only: [:create, :destroy, :index, :update]
    resources :trade_items, only: [:create, :destroy, :index]
    resources :images, only: [:create, :update, :destroy]
  end

end
