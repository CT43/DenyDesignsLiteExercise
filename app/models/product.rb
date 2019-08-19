class Product < ApplicationRecord
  has_many :product_vendor_allocations
  has_many :vendors, through: :product_vendor_allocations

  accepts_nested_attributes_for :product_vendor_allocations

  validates :name, :sku, presence: true, allow_blank: false
  validates :sku, uniqueness: true 
end
