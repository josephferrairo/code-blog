Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "posts#index"
  resources :posts
  resources :profiles, only: [:index, :show]
end
