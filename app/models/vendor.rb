class Vendor < ApplicationRecord
  has_many :product_vendor_allocations
  has_many :products, through: :product_vendor_allocations

  validates :name, presence: true, allow_blank: false
end
