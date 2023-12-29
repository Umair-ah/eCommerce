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
    if current_user.try(:type)
      @orders = Order.where(status: 0)
    else
      @orders = current_user.orders
    end
  end

  def show
    @order = Order.find(params[:order_id])
  end

  def index_marked
    @orders = Order.where(status: 1)

  end

  def mark_delivered
    @orders = Order.where(status: 0)
    @order = Order.find(params[:order_id])
    @order.delivered!
    flash.now[:notice] = "Order-#{@order.id} Marked Delivered."
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        [
          turbo_stream.update(
            "admin_orders",
            partial: "orders/admin_orders",
            locals: {order: @order}
          ),
          turbo_stream.update(
            "flash_#{current_user&.id}",
            partial: "layouts/flash",
          )
        ]
      }
    end
  end

  def mark_undelivered
    @orders = Order.where(status: 1)
    @order = Order.find(params[:order_id])
    @order.pending!
    flash.now[:alert] = "Order-#{@order.id} Marked Un-Delivered."
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        [

          turbo_stream.update(
            "admin_orders_delivered",
            partial: "orders/admin_orders_delivered",
            locals: {order: @order}
          ),
          turbo_stream.update(
            "flash_#{current_user&.id}",
            partial: "layouts/flash",
          )
        ]
      }
    end
  end

end