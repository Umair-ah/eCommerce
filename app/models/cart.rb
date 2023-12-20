class Cart < ApplicationRecord
  belongs_to :user

  has_many :line_items # current_cart.line_items
  has_many :products, through: :line_items # current_cart.products
end
