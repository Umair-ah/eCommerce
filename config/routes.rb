Rails.application.routes.draw do
  devise_for :users
  resources :products
  root "products#index"

  get "/carts/:id", to:"carts#show", as: "carts"
  
  post "line_items_buy_now/:product_id", to: "line_items#buy_now", as: "line_item_buy_now"
  post "line_items_add_to_cart/:product_id", to: "line_items#add_to_cart", as: "line_item_add_to_cart"
  post "line_items_add_quantity/:product_id", to: "line_items#add_quantity", as: "line_item_add_quantity"
  post "line_items_subtract_quantity/:product_id", to: "line_items#subtract_quantity", as: "line_item_subtract_quantity"
  get "add_product_from_index/:product_id", to: "line_items#add_product_from_index", as: "add_product_from_index"
  post "line_items_add_to_cart_from_index/:product_id", to: "line_items#add_to_cart_from_index", as: "line_item_add_to_cart_from_index"



  get "customer_address", to: "customers#customer_address", as:"customer_address"
  get "customer_address_turbo", to: "customers#customer_address_turbo", as:"customer_address_turbo"



  post "customer_address_update", to: "customers#customer_address_update", as:"customer_address_update"

  delete "line_item_delete_from_cart/:product_id", to: "line_items#destroy_from_cart", as: "destroy_from_cart"
end
