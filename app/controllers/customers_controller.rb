class CustomersController < ApplicationController

  def customer_address_update
    current_user.update!(address: params[:address])
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        turbo_stream.update(
          "current_user_address#{current_user.id}",
          partial: "carts/address",
          locals: {current_user: current_user}
        )
      }
    end
  end

  def customer_address

  end
end