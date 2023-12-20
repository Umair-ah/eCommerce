class ApplicationController < ActionController::Base

  before_action :set_current_user

  def set_current_user
    if current_user && current_user.cart.nil?
      cart = Cart.create
      session[:cart_id] = cart.id
      cart.update!(user: current_user)
      @current_cart = cart
    elsif current_user && current_user.cart.present?
      cart = Cart.where(user_id: current_user.id).last
      session[:cart_id] = cart.id
      @current_cart = cart
    end
  end
end
