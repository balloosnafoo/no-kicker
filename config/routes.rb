Rails.application.routes.draw do
  # root to: "/"

  resources :users
  resource :session
end
