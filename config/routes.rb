Rails.application.routes.draw do
  devise_for :users
  resources :products
  root "products#index"

  get "/carts/:id", to:"carts#show", as: "carts"
  
end
