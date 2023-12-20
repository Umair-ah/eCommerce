class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :order, optional: true

  def total_of_single_product
    self.product.price * self.quantity
  end
  
end
