Rails.application.routes.draw do
  root :to => "static_pages#home"

  resources :users
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :leagues
    resources :teams
    resources :league_memberships, only: [:create, :destroy]
    resources :score_rules, only: [:edit, :update]
    resources :roster_rules, only: [:edit, :update]
    resources :players, only: [:index, :show]
  end
end
