Rails.application.routes.draw do
  root :to => "static_pages#home"

  resources :users
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :leagues
    resources :teams
  end
end
