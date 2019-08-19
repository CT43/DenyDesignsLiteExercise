class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :vendor

  validates :order, :product, :vendor, :sku, presence: true
end
