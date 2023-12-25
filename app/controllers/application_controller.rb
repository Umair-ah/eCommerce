class ApplicationController < ActionController::Base

  before_action :set_current_user
  # before_action :set_razorpay_order


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

  # def set_razorpay_order
  #   if @current_cart.sub_total > 0
  #     @order = Razorpay::Order.create(amount: (@current_cart.sub_total.to_i * 100), currency: 'INR', receipt: 'TEST')
  #   end
  # end
end
