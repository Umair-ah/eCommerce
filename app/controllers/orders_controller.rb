class OrdersController < ApplicationController

  def order
    order = Order.create
    order.user = current_user
    @current_cart.line_items.each do |line_item|
      order.line_items << line_item
    end
    order.save!
    new_cart = Cart.create(user: current_user)
    session[:cart_id] = nil
  end

  def success

  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:order_id])
  end

end