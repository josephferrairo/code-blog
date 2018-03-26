Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "posts#index"
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  resources :profiles, except: [:destroy]
end
